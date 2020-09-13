(*
    Data Query Workflows Mathematica unit tests
    Copyright (C) 2020  Anton Antonov

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

   	Written by Anton Antonov,
	  antononcube@gmail.com,
	  Windermere, Florida, USA.
*)

(*

   The unit tests in this file are for the WL translations derived with
   the Raku package DSL::English::DataQueryWorkflows. See:

        https://github.com/antononcube/Raku-DSL-English-DataQueryWorkflows

   In the translations of Raku's DSL::English::DataQueryWorkflows are obtained
   in WL with the package "ExternalParsersHookUp.m" from this repository:

        https://github.com/antononcube/ConversationalAgents/blob/master/Packages/WL/ExternalParsersHookup.m

*)

BeginTestSection["DataQueryWorkflows-Unit-Tests.wlt.mt"];

(***********************************************************)
(* Load packages                                           *)
(***********************************************************)

VerificationTest[
  Import["https://raw.githubusercontent.com/antononcube/ConversationalAgents/master/Packages/WL/ExternalParsersHookup.m"];
  Length[DownValues[ExternalParsersHookup`ToDataQueryWorkflowCode]] > 0
  ,
  True
  ,
  TestID -> "LoadPackage-1"
];


VerificationTest[
  Import["https://raw.githubusercontent.com/antononcube/MathematicaForPrediction/master/MathematicaForPredictionUtilities.m"];
  Length[DownValues[MathematicaForPredictionUtilities`ImportCSVToDataset]] > 0
  ,
  True
  ,
  TestID -> "LoadPackage-2"
];


VerificationTest[
  Import["https://raw.githubusercontent.com/antononcube/MathematicaForPrediction/master/DataReshape.m"];
  Length[DownValues[DataReshape`ToLongForm]] > 0
  ,
  True
  ,
  TestID -> "LoadPackage-3"
];


(***********************************************************)
(* Load data                                               *)
(***********************************************************)

VerificationTest[
  dfTitanic = ImportCSVToDataset["https://raw.githubusercontent.com/antononcube/MathematicaVsR/master/Data/MathematicaVsR-Data-Titanic.csv"];
  dfStarwars = ImportCSVToDataset["https://raw.githubusercontent.com/antononcube/R-packages/master/DataQueryWorkflowsTests/inst/extdata/dfStarwars.csv"];
  dfStarwarsFilms = ImportCSVToDataset["https://raw.githubusercontent.com/antononcube/R-packages/master/DataQueryWorkflowsTests/inst/extdata/dfStarwarsFilms.csv"];
  dfStarwarsStarships = ImportCSVToDataset["https://raw.githubusercontent.com/antononcube/R-packages/master/DataQueryWorkflowsTests/inst/extdata/dfStarwarsStarships.csv"];
  dfStarwarsVehicles = ImportCSVToDataset["https://raw.githubusercontent.com/antononcube/R-packages/master/DataQueryWorkflowsTests/inst/extdata/dfStarwarsVehicles.csv"];
  Dimensions /@ {dfTitanic, dfStarwars, dfStarwarsFilms, dfStarwarsStarships, dfStarwarsVehicles}
  ,
  {{1309, 5}, {87, 11}, {173, 2}, {31, 2}, {13, 2}}
  ,
  TestID -> "LoadData"
];


(***********************************************************)
(* Select columns                                          *)
(***********************************************************)

VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwars; select name and mass", "Execute" -> True];
  obj = dfStarwars;
  obj = (KeyTake[#1, {"name", "mass"}] &) /@ obj;
  res1 == obj
  ,
  True
  ,
  TestID -> "Select-1"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwars; select 'name' and 'mass'", "Execute" -> True];
  ReleaseHold @ Hold[obj = dfStarwars; obj = (KeyTake[#1, {"name", "mass"}] &) /@ obj];
  res1 == obj
  ,
  True
  ,
  TestID -> "Select-2"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwars; select name, height, and mass;", "Execute" -> True];
  obj = dfStarwars;
  obj = (KeyTake[#1, {"name", "height", "mass"}] &) /@ obj;
  res1 == obj
  ,
  True
  ,
  TestID -> "Select-3"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwars; select name2 = name, height2 = height2, and mass2 = mass;", "Execute" -> True];
  ReleaseHold @ Hold[obj = dfStarwars;
  obj = ((Join[#1,
    Association["name2" -> #1["name"], "height2" -> #1["height2"], "mass2" -> #1["mass"]]] &) /@ obj)[All,
    Keys[Association["name2" -> #1["name"], "height2" -> #1["height2"], "mass2" -> #1["mass"]]]]];
  res1 == obj
  ,
  True
  ,
  TestID -> "Select-assign-pairs-1"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwars; select name as name2, and mass as MASS;", "Execute" -> True];
  ReleaseHold @ Hold[obj = dfStarwars;
  obj = ((Join[#1,
    Association["name2" -> #1["name"], "MASS" -> #1["mass"]]] &) /@ obj)[All,
    Keys[Association["name2" -> #1["name"], "MASS" -> #1["mass"]]]]];
  res1 == obj
  ,
  True
  ,
  TestID -> "Select-as-pairs-1"
];


(***********************************************************)
(* Rename columns                                          *)
(***********************************************************)

VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwars; rename name as name2, and mass as MASS;", "Execute" -> True];
  ReleaseHold @ Hold[obj = dfStarwars;
  obj = ((Join[#1,
    Association["name2" -> #1["name"], "MASS" -> #1["mass"]]] &) /@ obj)[All,
    Keys[Association["name2" -> #1["name"], "MASS" -> #1["mass"]]]]];
  res1 == obj
  ,
  True
  ,
  TestID -> "Rename-as-pairs-1"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwars; rename name as name2, and mass as MASS;", "Execute" -> True];
  res2 = ToDataQueryWorkflowCode["use dfStarwars; select name as name2, and mass as MASS;", "Execute" -> True];
  res1 == res2
  ,
  True
  ,
  TestID -> "Rename-vs-select-with-as-pairs-1"
];


(***********************************************************)
(* Delete duplicates                                       *)
(***********************************************************)

VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwarsStarships; unique rows", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfStarwarsStarships;
        obj = DeleteDuplicates[obj]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Delete-duplicates-1"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfTitanic; select passengerClass, passengerSex; delete duplicates", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfTitanic;
        obj = (KeyTake[#1, {"passengerClass", "passengerSex"}] &) /@ obj;
        obj = DeleteDuplicates[obj]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Delete-duplicates-2"
];


(***********************************************************)
(* Filter rows                                             *)
(***********************************************************)

VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfTitanic; filter with passengerClass is '1st' and passengerSex is 'male'", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfTitanic;
        obj = Select[obj, #1["passengerClass"] == "1st" && #1["passengerSex"] == "male" &]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Filter-rows-1"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfTitanic; filter with passengerClass is '1st' and passengerSex is 'male' or passengerAge is greater than 50", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfTitanic; obj =
            Select[obj, (#1["passengerClass"] == "1st" && #1["passengerSex"] == "male") || #1["passengerAge"] > 50 &]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Filter-rows-2"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfTitanic; filter with passengerClass is '1st' and passengerSex is 'male'", "Execute" -> True];
  res2 = ToDataQueryWorkflowCode["use dfTitanic; filter with passengerClass == '1st' && passengerSex equals 'male'", "Execute" -> True];
  res1 == res2
  ,
  True
  ,
  TestID -> "Filter-rows-3"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfTitanic; filter with passengerClass is '1st' and passengerSex is 'male' or passengerAge is greater than 50", "Execute" -> True];
  res2 = ToDataQueryWorkflowCode["use dfTitanic; filter with passengerClass == '1st' && passengerSex == 'male' || passengerAge > 50", "Execute" -> True];
  res1 == res2
  ,
  True
  ,
  TestID -> "Filter-rows-4"
];


(***********************************************************)
(* Inner joins                                             *)
(***********************************************************)

VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwarsStarships; inner join with dfStarwarsVehicles", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfStarwarsStarships;
        obj = JoinAcross[obj, dfStarwarsVehicles, Normal[Keys[obj[1]]] ~ Intersection ~ Normal[Keys[dfStarwarsVehicles[1]]], "Inner"]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Inner-join-1"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwarsStarships; inner join with dfStarwarsVehicles by name", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfStarwarsStarships;
        obj = JoinAcross[obj, dfStarwarsVehicles, {"name"}, "Left"]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Inner-join-2"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwarsStarships; inner join with dfStarwarsVehicles by 'name'", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfStarwarsStarships;
        obj = JoinAcross[obj, dfStarwarsVehicles, {"name"}, "Left"]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Inner-join-2"
];

VerificationTest[
  res1 = ToDataQueryWorkflowCode["
  use dfStarwarsStarships;
  rename name as character;
  inner join with dfStarwarsVehicles by character = name",
    "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfStarwarsStarships;
        obj = ((Join[#1, Association["character" -> #1["name"]]] &) /@ obj)[All, Keys[Association["character" -> #1["name"]]]];
        obj = JoinAcross[obj, dfStarwarsVehicles, {"character" -> "name"}, "Left"]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Inner-join-3"
];


(***********************************************************)
(* Right joins                                             *)
(***********************************************************)

VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwars; right join with dfStarwarsVehicles", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfStarwars;
        obj = JoinAcross[obj, dfStarwarsVehicles, Normal[Keys[obj[1]]] ~ Intersection ~ Normal[Keys[dfStarwarsVehicles[1]]], "Right"]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Right-join-1"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfStarwars; right join with dfStarwarsVehicles by name", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfStarwars;
        obj = JoinAcross[obj, dfStarwarsVehicles, {"name"}, "Right"]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Right-join-2"
];


(***********************************************************)
(* Cross tabulation                                        *)
(***********************************************************)

VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfTitanic; cross tabulate passengerSex and passengerClass", "Execute" -> True];
  ReleaseHold @
      Hold[obj = dfTitanic;
      obj = GroupBy[obj, {#1["passengerSex"], #1["passengerClass"]} &, Length]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Crass-tabulation-1"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfTitanic; cross tabulate passengerSex and passengerClass over passengerAge", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfTitanic;
        obj = GroupBy[obj, {#1["passengerSex"], #1["passengerClass"]} &, Total[(#1["passengerAge"] &) /@ #1] &]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Crass-tabulation-2"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfTitanic; cross tabulate passengerSex", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfTitanic;
        obj = GroupBy[obj, #1["passengerSex"] &, Length]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Crass-tabulation-3"
];


VerificationTest[
  res1 = ToDataQueryWorkflowCode["use dfTitanic; cross tabulate passengerSex over passengerAge", "Execute" -> True];
  ReleaseHold @
      Hold[
        obj = dfTitanic;
        obj = GroupBy[obj, #1["passengerSex"] &, Total[(#1["passengerAge"] &) /@ #1] &]
      ];
  res1 == obj
  ,
  True
  ,
  TestID -> "Crass-tabulation-4"
];


(***********************************************************)
(* To long form                                            *)
(***********************************************************)


(***********************************************************)
(* To wide form                                            *)
(***********************************************************)



EndTestSection[]
