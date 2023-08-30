{-# LANGUAGE CPP, ExistentialQuantification, ForeignFunctionInterface #-}

module Text.Unac (
  utf8Encode,
  unacVersion,
  unacString,
  unacStringUtf8
  ) where

import Foreign.C
import Foreign.Ptr
import Foreign.Storable
import Foreign.Marshal

type InputEncode = String

type CInputEncode = CString
type CInputString = CString
type CInputStringLength = CLong
type COuputString = Ptr CString
type COuputStringLength = Ptr CLong

utf8Encode :: InputEncode
utf8Encode = "UTF-8"

unacVersion :: IO String
unacVersion = c_unac_version >>= peekCString

unacString :: InputEncode -> String -> IO (Either Int String)
unacString encode inputString =
  withCString encode $ \cEncode -> do
    withCStringLen inputString $ \(cInputString,cInputStringLength) -> do
      cOutputString :: CString <- callocArray (2 * (fromIntegral cInputStringLength))
      cOutputStringRef :: (Ptr CString) <- calloc
      poke cOutputStringRef cOutputString
      alloca $ \(cOutputStringLength :: (Ptr CLong)) -> do
        res <- c_unac_string
             cEncode
             cInputString
             (fromInteger $ fromIntegral cInputStringLength)
             cOutputStringRef
             cOutputStringLength
        free cOutputStringRef
        case res of
          0 -> do
            outputString <- peekCString cOutputString
            free cOutputString
            return (Right outputString)
          _ -> free cOutputString >> return (Left res)

unacStringUtf8 :: String -> IO (Either Int String)
unacStringUtf8 = unacString utf8Encode
{-# INLINE unacStringUtf8 #-}

foreign import ccall "unac_version" c_unac_version :: IO CString

foreign import ccall "unac_string" c_unac_string :: CInputEncode
                                                 -> CInputString
                                                 -> CInputStringLength
                                                 -> COuputString
                                                 -> COuputStringLength
                                                 -> IO Int
