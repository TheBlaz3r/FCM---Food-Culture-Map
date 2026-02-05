//
//  GameUtils.swift
//  ProgettoFinale
//
//  Created by Foundation 2 on 03/02/26.
//

func convertClues(clues: String) -> [String] {
    var newClues: [String] = []
    var clue: String = ""
    for char in clues {
        if char == "," {
            newClues.append(clue)
            clue = ""
            continue
        }
        clue.append(char)
    }
    return newClues
}

func selectRandomFood() {
    viewModel.fetchRecords()
    guard viewModel.records.count != 0 else { return }
    let foodRecords = viewModel.records

    let randomIdx = Int.random(in: 0..<foodRecords.count)
    let randomFood: Fields = foodRecords[randomIdx].fields

    let newClues = convertClues(clues: randomFood.Clues!)

    if let attachment = randomFood.Image?.first {
        let foodImage = GameFoodImageView(attachment: attachment)
        selectedDish = Dish(
            name: randomFood.FoodName!,
            country: randomFood.Country!,
            image: foodImage,
            clues: newClues
        )
    }
}

var selectedDish: Dish? = Dish(
    name: "c",
    country: "c",
    image: GameFoodImageView(
        attachment:
            AirtableAttachment(
                id: "attFYPOsFQXb0nGaH",
                url:
                    "https://v5.airtableusercontent.com/v3/u/50/50/1770134400000/MfO_uloK4i0qeE-s88EAng/afxNACHCQNcAPPSbyNo1w5I2DTzi2SIizs2krobICIlgwzAN8RS14q2u9UIHh1C2jT2T5C1eBBIQkpceehalwyAvuv0-wURseQH-4r3PzvUO2s2k6pCuaU4p2T7hITs7GrBcIvCSTUU07voXS5N-uQ/_Y_Ej1ZLKIkF3rYnxTZSN3tgmRjPNl8cMmzVf_dptlI",
                filename: "gaz.jpg",
                size: 314894,
                type: "image/jpeg",
                thumbnails: AirtableAttachment.Thumbnails(
                    small: Optional(
                        ProgettoFinale.AirtableAttachment.Thumbnail(
                            url:
                                "https://v5.airtableusercontent.com/v3/u/50/50/1770134400000/bCjQ52ETZS6dsj-OFiTJuA/It6VqMnXCYPUTAzFJo_kVmgBn0pflTyKMTUT02m55xxiicNLql6nzC4fxYjxXNkcHGDNiiiKLcmBZIiZtm8vUU9B2bVGA4_G_vTi-FV_aBzu91GJ-yMjYLZOQAGIOR087Scu0a88gtNpmEa1XWumzg/pKQ01UmDNJwFvUiR2BddqYDF_PA9N38M04kS2D5coD4",
                            width: 47,
                            height: 36
                        )
                    ),
                    large: Optional(
                        ProgettoFinale.AirtableAttachment.Thumbnail(
                            url:
                                "https://v5.airtableusercontent.com/v3/u/50/50/1770134400000/ZKHpz0HuhVq7_8EzpxfHjg/kEPLdHZzpHXXqePRIlzlmjGOPT1kb0OhoWbI2yShaLzwA0e-sy8h15UfpGzFcSDqtdtZeyv_tcnipEDifdUWpKAsvPlMOu-Hb0aM18Qqpl2FYIDkHynbelfh1xqtI1fwHzT-b1ZujE3kwWUVC0-Ktw/AZo0ooLfXnhZGmG4rjf5vrdIO1Po_kK4Mi0-XpMM4vc",
                            width: 664,
                            height: 512
                        )
                    ),
                    full: Optional(
                        ProgettoFinale.AirtableAttachment.Thumbnail(
                            url:
                                "https://v5.airtableusercontent.com/v3/u/50/50/1770134400000/PX-YMwFZDbwzcAKTZhotoA/-s80b0Ra7kCbw-agsv_FMtBqPQLCmVlX3eq4nqMLVCY9uKKXjDjJihb9vMGWFDhiYo1obccthPF2IJx0Z5dqzGasCEwe_eS8YLsmRrdUNEfn1vnAeqpfnACwfWHxhov3WJvhZAVbua0fU1Xj13D1lQ/Ykc0df-J2KNqpq1m7gdgivp30X60MBCzrxQih6gDKsI",
                            width: 705,
                            height: 544
                        )
                    )
                )
            )
    ),
    clues: ["c", "df", "ghbjn"]
)

