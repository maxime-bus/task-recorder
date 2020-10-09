module TaskBackup where

import           Data.Time
import           System.Directory
import           System.IO
import           Task

-- file format
--
-- DONE startdate enddate topic
-- DONE startdate enddate topic
-- DONE startdate enddate topic
-- IN_PROGRESS startdate topic
defaultPath = (++ "/.tasks") <$> getHomeDirectory

dateFormat = "%Y-%m-%dT%H:%M:%S"

formatDate = formatTime defaultTimeLocale dateFormat

parseDate = parseTimeM False defaultTimeLocale dateFormat

serializeTask :: Task -> String
serializeTask (Done s e t) = "DONE" ++ " " ++ formatDate s ++ " " ++ formatDate e ++ " " ++ t
serializeTask (InProgress s t) = "IN_PROGRESS" ++ " " ++ formatDate s ++ " " ++ t

serializeTasks :: [Task] -> String
serializeTasks = concatMap ((++ "\n") . serializeTask)

saveTasks :: [Task] -> FilePath -> IO ()
saveTasks tasks filepath = writeFile filepath (serializeTasks tasks)

parseTask :: String -> Maybe Task
parseTask s = parseTask' $ words s
  where
    parseTask' ("DONE":s:e:t) = do
      startDate <- parseDate s
      endDate <- parseDate e
      return $ Done startDate endDate (unwords t)
    parseTask' ("IN_PROGRESS":s:t) = do
      startDate <- parseDate s
      return $ InProgress startDate (unwords t)
    parseTask' _ = Nothing

loadTasks :: FilePath -> IO [Task]
loadTasks path = do
  contents <- lines <$> readFile path
  case mapM parseTask contents of
    Nothing    -> error "file is corrupted"
    Just tasks -> return tasks
