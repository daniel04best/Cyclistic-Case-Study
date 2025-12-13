

![Case-Study](https://github.com/daniel04best/Cyclistic-Case-Study/blob/main/224968385-9521ab10-d278-4595-a829-08b4f1c645be.png?raw=true)

![SQL](https://img.shields.io/badge/Language-SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![Tableau](https://img.shields.io/badge/Tool-Tableau-E97627?style=for-the-badge&logo=tableau&logoColor=white)
![Google](https://img.shields.io/badge/Certificate-Google%20Data%20Analytics-4285F4?style=for-the-badge&logo=google)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)]({{ site.social.linkedin_url }})


**📒Introduction**

This case study is the capstone project for the Google Data Analytics Professional Certificate. In this scenario, I assume the role of a Junior Data Analyst working for Cyclistic, a fictional bike-share company in Chicago.

**The Scenario**

Cyclistic’s Director of Marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, the marketing team needs to understand how Casual Riders and Annual Members use Cyclistic bikes differently.

**My Objective**

I have been tasked with analyzing 12 months of historical trip data to identify behavioral trends. (Data: [Divvy Tripdata (S3 Index)]({{ site.data_sources.divvy_link }})) My goal is to produce clear, data-driven insights and visualizations that will help the executive team design a new marketing strategy to convert casual riders into loyal annual members.

**Tools Used:**

- SQL (BigQuery): For data warehousing, cleaning, and merging 5.7 million rows of data.

- Tableau: For creating interactive dashboards and visualizing usage trends.


**❓Ask Phase**

**What is the business problem?**

The Director of Marketing, Lily Moreno believes the company's future success depends on maximizing the number of annual memberships. The problem is that while casual riders are already aware of Cyclistic and use the service for their mobility needs, they have **not committed** to an annual plan. The goal is to determine how to effectively convert these casual riders into annual members, as financial analysts have concluded members are much more profitable.

**How can my insights drive business decisions?** 

My insights will reveal the specific behavioral differences between how annual members and casual riders use the bikes. By understanding these differences (such as trip duration, frequency, or preferred days of the week), the marketing team can design a targeted strategy that specifically appeals to casual riders to encourage them to join. High-quality insights and visualizations are required to get approval from the Cyclistic executive team.

**Key Stakeholders**

- Director of Marketing: Lily Moreno. She is responsible for developing campaigns and assigned me this specific problem. 
- Cyclistic Executive Team: The detail-oriented executives who will decide whether to approve the recommended marketing program based on my data insights.
-  Cyclistic Marketing Analytics Team: My team of peers who act as secondary stakeholders in guiding the marketing strategy. 

**Clear Statement of the business task**

"The business task is to analyze Cyclistic's historical usage data to identify distinct behavioral differences between annual members and casual riders. These insights will be used to support the marketing team in designing a data-driven strategy to convert casual riders into profitable annual members."

**✅Prepare Phase**

**Data Location and Source:**
I used Cyclistic’s **historical trip data** to analyse and identify trends. The data is publicy available. The data is organized in 12 monthly CSV files covering historical trip data. 
**Integrity:** The data is first-party data collected directly by Cyclistic ensuring reliability and accuracy for identifying patterns. It covers a full calendar year, allowing to analyse seasonality and includes start/end times, station names and bike types. 
Privacy: All riders’ PII (personally identifiable information) has been removed, such as connections to credit card numbers. Due to this anonymity restriction, I cannot track if a casual rider is the same person taking multiple trips or different people. 

I downloaded the **12 zip files** containing data from each month of the year 2024 through the Divvy Trip Data website (Data: [Divvy Tripdata (S3 Index)]({{ site.data_sources.divvy_link }})). 
I created a folder on my computer named Cyclicstic_Project. Inside I created 01_Raw_Data and 02_Cleaned_Data so I could have an **original copy of the raw data** and use the second to edit and clean the data. 

***⚙️Process Phase***

For this phase of the project I chose different tools for different tasks. Because Excel has a limited number of rows that it can process, I chose to use SQL through the BigQuery interface to clean the data. 
I merged all 12 monthly CSV files into a single table using a **Google Cloud Storage bucket** and creating a table on BigQuery with that bucket. 

Two new columns required for analysis were created:
- ride_length_m: Calculated by finding the time difference between ended_at and started_at in minutes (using TIMESTAMP_DIFF).
- day_of_week: Extracted the day of the week from the started_at column (using EXTRACT(DAYOFWEEK FROM...)).
- 
**Filtering:**
The dataset was filtered to remove outliers and null values:
- Removed Nulls: Excluded rows where start_station_name or end_station_name were missing (IS NOT NULL).
- Removed Outliers: Filtered out rides with a duration less than 1 minute (likely false starts or docking errors) and rides over 24 hours (1440 minutes). 
This cleaning process ensured the integrity of the data by creating a final table only with rows that met the **necessary criteria** (no nulls and valid duration).


**Data Field Types**

![data_fields](https://github.com/daniel04best/Cyclistic-Case-Study/blob/main/Screenshot%202025-12-13%20203120.png?raw=true)

**Example SQL Data**

![sql_data](https://github.com/daniel04best/Cyclistic-Case-Study/blob/main/Screenshot%202025-12-13%20203400.png?raw=true)

**📑Analyze Phase:**

**Analysis and Key Findings**

**Data Organization:**
To perform an effective analysis on the large dataset (approx. 5.7 million rows), the data was organized in Google BigQuery.
I merged the 12 monthly files into one to facilitate analysis using SQL.
**Formatting:** The data was formatted by ensuring consistent column data types (Timestamp for dates, Float for duration). Two critical calculated columns were added to enable analysis: ride_length (calculated in minutes) and day_of_week (extracted from the start date).
**Aggregation:** For visualization performance, the data was further organized into a summary table grouped by date and user type, reducing file size so it would be easier to handle in Tableau. 

**Surprises in the Data**

**Ride Duration:**
The most surprising discovery was the magnitude of the difference in ride duration. Casual riders consistently ride for around twice as much per trip than annual members. This strongly contradicts the assumption that members would use the service more intensively. 
**Seasonal Drop-off:**
While a seasonal drop-off was expected, the data revealed that casual ridership drops a lot more intensely in winter months than members of the service, likely due to commuting needs, as members want to get their money’s worth even during the winter months. 
**Trends Identified:**
Both groups of customers peak in the summer months, although the casual riders are much more sensitive to seasonality than members. 
**Strategy Implication:**
To convert casual riders, marketing strategies should not focus on "utility" or "commuting" (which they don't do), but rather on the financial benefit of an annual pass for "weekend fun" or seasonal summer usage.

Due to the significant volume of the dataset (approximately 5.7 million rows), directly importing raw data into Tableau Public caused performance latency and file-size constraints. To resolve this, I performed SQL-based aggregation in BigQuery to create a streamlined summary table.
By grouping the data by date and user type within the database, I pre-calculated key metrics (ride count and average duration). This reduced the dataset size from over 1 GB to less than 1 MB while preserving the daily granularity required for analysis, ensuring the final dashboard is both responsive and efficient.

**Casual vs Member Total Rides:**

<p align="center">
  <img src="https://github.com/daniel04best/Cyclistic-Case-Study/blob/main/Sheet%204%20(1).png?raw=true" width="300" height="300" alt="Weekly Usage">
</p>
<br>

**Casual vs Member Summary Data:**

![member_data](https://github.com/daniel04best/Cyclistic-Case-Study/blob/main/Screenshot%202025-12-10%20155224.png?raw=true)

**Days of the Week Data Comparison (Casual vs Member):**

![daysoftheweek_data](https://github.com/daniel04best/Cyclistic-Case-Study/blob/main/Screenshot%202025-12-10%20162046.png?raw=true)


**✨Share Phase:**

**Answering the Business Question:**

Yes, this analysis successfully answered the question. We can see that the data revealed distinct and opposing behavioral patterns in how the two groups use the product. The Annual Members use the system for commuting (shorter and more predictable trips) while the Casual Riders use the system for leisure purposes (longer and weekend-concentrated trips).

**Findings:**
The Commuters usage creates a bell curve during the week, as the primary use is during working hours and working days. 
The Leisure riders usage creates a bowl shape where ridership surges on the weekend. They ride around 2x longer and primarily on the weekend. This indicates that the marketing team could use a utility for commuting ad for members and focus on leisure ads for the casual riders.

**Communication Strategy:**
To communicate with the stakeholders, concise and high-level visual insights are the best option. They wouldn’t need to see SQL code. They want easily identifiable trends through visualizations to justify spending more on marketing. 

**Data Visualization:**
To create visualizations that would communicate clearly and provide easily identifiable trends, line charts for weekly and seasonal ridership between both groups was a powerful tool that clearly shows trends over time. To show average ride length between Casual Riders and Members, a simple bar chart was the most effective. 
I chose Red for the Casual Riders (Target Audience) and Gray for the Members (baseline audience) to provide a quick high-contrast difference between the two and to direct attention. I added clear titles with description of the visuals so the takeaways are immediate. 


### Visualizations


**1. Average Ride Length**
**Casual riders ride twice as long as members.**
<p align="center">
  <img src="https://github.com/daniel04best/Cyclistic-Case-Study/blob/main/Sheet%201.png?raw=trueE" width="320" height="600" alt="Weekly Usage">
</p>
<br>

**2. Weekly Usage Patterns**
**Casual riders dominate the weekends.**
<p align="center">
  <img src="https://github.com/daniel04best/Cyclistic-Case-Study/blob/main/Sheet%202.png?raw=true" width="520" height="550" alt="Weekly Usage">
</p>
<br>

**3. Seasonality**
**Ridership peaks in July/August.**

<p align="center">
  <img src="https://github.com/daniel04best/Cyclistic-Case-Study/blob/main/Sheet%203.png?raw=true" width="700" height="550" alt="Weekly Usage">
</p>
<br>


**Check out the interactive dashboard on Tableau Public:**
 (Data: [TableauSite]({{ site.visualizations.tableau_link }}))



**🌐Act Phase:**

**Final Conclusion**
Based on the analysis, the difference between the two groups is clear: Cyclistic serves two distinct markets.
Annual Members are "Commuters" who use the system for quick, predictable travel to work or school during the week.
Casual Riders are "Leisure Users" who use the system for fun, exercise, or tourism, primarily on weekends and during the summer months.

**Conclusion:**
The current marketing strategy which focuses on utility and commuting—is missing the mark with Casual riders. To convert them, we must pivot to selling "entertainment" and "weekend access."

**How to Apply these Insights:**
The marketing team can apply these insights by segmenting the marketing strategy. Instead of just marketing that the service can get from one point to another, it should distinguish between Casual riders where the marketing should focus on messages that encourage exploration and leisure activities and be more focused on peak months in the summer. 

**Stakeholder Next Steps:**
The director of marketing Lily Moreno should review the findings to approve this new campaign. The marketing team should develop new creative assets that support this new narrative. The executive team should evaluate the financial feasibility of the campaign. 

**Additional Data Opportunities:**
Due to data-privacy regulations, this analysis didn’t include age, gender or any demographic data of users. Survey data could help determine if casual riders are just visiting Chicago for tourism or if they live there but choose to not get an annual pass. 


**Top Three Recommendations based on the 12 months of trip data:**

-	**A Targeted Commuter Trial Month**

Casual riders primarily use bikes on the weekends, which limits their perceived value of annual membership. By offering a one-month free trial specifically during June, a peak month, it shifts their behavior from weekend leisure to weekday utility. 

Additionally, Cyclisitic could gamify this trial period. Users who complete at least 5 weekday trips while on the trial month would get a discount on the Annual Membership Plan. 

-	**Gamify the Riding Experience to Drive Conversion**

Casual riders’ ride length is about twice as long on average as members. By introducing gamification to the Cyclisitc app accessible to all users, such as challenges like “Ride 15 miles this month” or “Visit 3 different neighborhoods”, casual riders can engage in these challenges and incentivize habit formation. These challenges and games should have rewards that unlock tangible discounts on Memberships, which drives conversion from Casual Riders to Members. 

-	**Optimize Digital Advertising based on weekly patterns**

Since the data reveals that casual ridership decreases during the workweek but spikes up on the weekends, the marketing team should shift the majority of the digital ad budget to run right before the weekend, like Thursday, Friday or Saturday mornings. This places ads in front of users right when they are planning their weekend activities. These ads must present specific financial value propositions such as temporary discounts on memberships that will incentivize casual riders to consider switching to a membership. 




**Contact: daniel04best@gmail.com**
