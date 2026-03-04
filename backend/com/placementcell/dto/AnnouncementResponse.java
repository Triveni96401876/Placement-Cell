package com.placementcell.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AnnouncementResponse {
    private Long id;
    private String title;
    private String description;
    private String announcementType;
    private String createdBy;
    private String createdAt;
}
