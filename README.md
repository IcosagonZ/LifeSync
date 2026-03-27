# LifeSync

![Milestone Progress](https://img.shields.io/github/milestones/progress/IcosagonZ/LifeSync/1)

> <picture>
>   <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/Mqxx/GitHub-Markdown/main/blockquotes/badge/light-theme/warning.svg">
>   <img alt="Warning" src="https://raw.githubusercontent.com/Mqxx/GitHub-Markdown/main/blockquotes/badge/dark-theme/warning.svg">
> </picture><br>
> This is a academic/personal project developed by an internal team, to ensure integrity of codebase for academic and professional review, I will not accept external contributions at this time.

> <picture>
>   <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/Mqxx/GitHub-Markdown/main/blockquotes/badge/light-theme/info.svg">
>   <img alt="Info" src="https://raw.githubusercontent.com/Mqxx/GitHub-Markdown/main/blockquotes/badge/dark-theme/info.svg">
> </picture><br>
> If you are interested in this project, feel free to fork the project and experiment with your own version under the AGPL license.

## About

LifeSyncAI is a student wellness app designed to analyze lifestlye habits and their influence on academic influence on students. This app integrates manually entered data like sleep duration, physical activity, study hours and grades with AI based food recognition for calorie estimation.

Food images uploaded by user will be processed using a deep learning model trained on Food 101 dataset with backend implemented using Python and Flask.

Front end will be made using Flutter for mobile friendly cross platform data entry, visualization and interaction. AI based analysis is applied to all data to identify trends to correlate lifestyle factors and academic outcomes.

## Screenshots
<p align="center">
    <img src="screenshots/screenshot_0.jpeg" alt="Home page" width="400"/>
    <img src="screenshots/screenshot_1.jpeg" alt="Timeline page" width="400"/>
</p>

<p align="center">
    <img src="screenshots/screenshot_2.jpeg" alt="Side bar" width="400"/>
    <img src="screenshots/screenshot_3.jpeg" alt="Recommendations page" width="400"/>
</p>

## Features
- Track academics, mental health, vitals, nutrition, activities, workouts, sleep etc...
- Analyze data for each day, month, year etc... and find trends
- Get ML recommendations and trends

## Tech stack used
- Flutter + Dart
- SQLite (sqlite3)

### Libraries used
- Material Symbols Icons
- Intl

## Running
- Update generated code using `dart run build_runner clean` and `dart run build_runner build`
- Run using `flutter run`

## References

1. <p>Syed Khaliq, Y. Jayasurya Reddy, and Y. Sriyukth Chowdary, “Food Calorie Estimation Using Deep Learning and Computer Vision,” International Journal of Engineering Technology Research & Management (IJETRM), vol. 9, no. 4, pp. 1–3, April 2025, ISSN 2456-9348, doi:10.5281/zenodo.15119775</p>

2. <p>Amugongo LM, Kriebitz A, Boch A, Lütge C. Mobile Computer Vision-Based Applications for Food Recognition and Volume and Calorific Estimation: A Systematic Review. Healthcare (Basel). 2022 Dec 26;11(1):59. doi: 10.3390/healthcare11010059. PMID: 36611519; PMCID: PMC9818870</p>

3. <p>S. M. J. Irfan, G. Dhivya, N. Raghavendran, M. C. Babu, T. Jasperline and R. Saravanakumar, "AI Personalized Mental Health Monitoring System using Machine Learning, and Natural Language Processing," 2025 International Conference on Data Science, Agents & Artificial Intelligence (ICDSAAI), Chennai, India, 2025, pp. 1-5, doi: 10.1109/ICDSAAI65575.2025.11011535</p>

## Trademark and Attribution
The name "LifeSync" and "LifeSyncAI" and its associated branding are the intellectual identity of IcosagonZ, you may not use these names, logos, or any derivative branding for any forks, redistributed versions or commercial implementations of this software without explicit written consent.
Any fork must be clearly identified as a "Community Fork" and must be renamed to avoid user confusion and to maintain the structural integrity of the original "LifeSync" architecture.
By forking or using this project or parts of it in any manner, you agree to these terms automatically.
