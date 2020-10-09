module Task where

import Data.Time

type Topic = String

type StartDate = UTCTime

type EndDate = UTCTime

data Task
  = Done StartDate EndDate Topic
  | InProgress StartDate Topic

closeTask :: Task -> EndDate -> Task
closeTask (InProgress s t) closeDate = Done s closeDate t
closeTask t _ = t

closeLastTask :: [Task] -> EndDate -> [Task]
closeLastTask [] _ = []
closeLastTask ts e = reverse $ closeTask (last ts) e : init ts

createTask :: StartDate -> Topic -> Task
createTask = InProgress

getStartDate :: Task -> StartDate
getStartDate (Done s _ _) = s
getStartDate (InProgress s _) = s

-- adds a task to the end, and closes the penultimate one
addTask :: [Task] -> Task -> [Task]
addTask [] t = [t]
addTask ts task = ts'
  where
    closedTask = closeTask (last ts) (getStartDate task)
    ts' = reverse $ task : closedTask : init ts
