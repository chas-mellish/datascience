#We are re-doing question 16 together from the assignment.
new_levels <- c("Mississippi", "Quebec") #Defining for plotting.
new_labels <- c("Nonchilled", "Chilled") #Defining for plotting.

CO2 %>%
  group_by(conc, Type, Treatment) %>%
  summarize(mean_uptake = mean(uptake)) %>%
  ungroup() %>%
  mutate(Type = factor(Type, levels = c(new_levels)),
         Treatment = factor(Treatment, labels = c(new_labels))) %>%
  ggplot(aes(x = factor(conc), y = mean_uptake, fill = Treatment)) +
  #By factor(conc) we force conc to be CATEGORIES.
  geom_bar(stat = "identity") +
  #Identity overrides counting to plot heights normally.
  facet_grid(Type ~ Treatment) +
  theme_bw() +
  theme(legend.position = "none") +
  #Removes the legend.
  labs(x = "CO2 Concentration", y = "Mean Uptake") +
  scale_fill_manual(values = c("goldenrod2", "brown"))
