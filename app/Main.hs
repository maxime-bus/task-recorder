module Main where

import           Data.Time
import           Lib
import           System.Environment
import           Task
import           TaskBackup

initCommand :: FilePath -> IO ()
initCommand path = writeFile path ""

logCommand :: FilePath -> Topic -> IO ()
logCommand path topic = do
  ts <- loadTasks path
  d <- getCurrentTime
  saveTasks (addTask ts (InProgress d topic)) path

displayCommand :: FilePath -> IO ()
displayCommand path = readFile path >>= putStrLn

main :: IO ()
main = do
  args <- getArgs
  path <- defaultPath
  case args of
    ("init":_)    -> initCommand path
    ("log":topic) -> logCommand path (unwords topic)
    ("display":_) -> displayCommand path
    _             -> putStrLn "unknown command"
