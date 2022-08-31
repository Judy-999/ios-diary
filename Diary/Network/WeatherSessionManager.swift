//
//  WeatherSessionManager.swift
//  Diary
//
//  Created by 백곰,주디 on 2022/08/31.
//

import Foundation

struct WeatherSessionManager {
    
    func requestWeatherInfomation(at city: String, completion: @escaping (Result<Data, WeatherError>) -> Void ) {
        let apiKey = "143bbe85021307632d1ce316ce1b9963"
        let wheatherUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid="
        guard let url = URL(string: wheatherUrl + apiKey) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, _) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return completion(.failure(WeatherError.failResponse))
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}