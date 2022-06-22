Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5CE554E8B
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Jun 2022 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358990AbiFVPE4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Jun 2022 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359040AbiFVPEV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:04:21 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A443E3EABF
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jun 2022 08:04:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 68so10907113pgb.10
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jun 2022 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=fedxHvpvYGaAl1C0u3mJS1WoqvPB0oNNv7icLw40leErOjShqlvVem53l7VAdJ6upZ
         L9z5WDHmzLExverqd2Mlj95gGjQNvvfXGnx/i35Q2Ukq7ibfZ94eDaBTK5a+fKxCwP9O
         nRqYHOUWNZbkQn4UDeTvF4NpuW50CznfhSBqvOQCWCJHDLNswJAJnAsJ8jsQqPdE4jnq
         COrGXKAi62bwJ046zRD4eFm00hgqMY3inLGwy6XN2qkeNHYLqNbYEBgBhwM15vCVcLdM
         zu151re4CU2NRmtTbOO+KWSATgrrIcFFv7vuukzb8K7ulGrwY+Hhv/D6dxqdTnZkPpNA
         PZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=flWjBQeZr5DHXK82aFFS+npOqGbhVKO4BI2+K/PtvWVcLaf+lhZNCjmcEK+9lMCX71
         q5Zd/LZmVueb54HVIn2PQrbyi6+7GYTB4RSP48psrUy40z7+GeqrNs8bvxfhkssfsZBW
         z1zBp5UloPgLMX3w/tXybL5pH8cEmEdepcUdhbb33820SBT0fzzJ+9fCJcfkt5tg/Wid
         oWDMhKlhAe1U2sGnklMpZNBNrbmwRHkgtYuDCLisi/fLmMKbe0NZjepr8nz1LU3qU+vV
         WMvQelV32OI7UShbk1gs+NH/+zHetRmVeeY3r401ByigKYr3A7hfbIVae3sj1E6sSL2d
         K5Vg==
X-Gm-Message-State: AJIora9xCaNJDWUO8AbpbsHlwzwGgfahvQObOm6/DWig4BRikSByFemt
        PNb7g+5NJAx8hFuztPI6qHdpo6qFfAQMBshtBng=
X-Google-Smtp-Source: AGRyM1tystIslg9uNVcUOMzYR8GYNz8Amo4b63MeZP0gXSY5EfclQ79Nr4WF60Irm+FNisTL7itfLErKePPDvZ9Q4yo=
X-Received: by 2002:a05:6a00:225a:b0:525:4d37:6b30 with SMTP id
 i26-20020a056a00225a00b005254d376b30mr1469916pfu.83.1655910260294; Wed, 22
 Jun 2022 08:04:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:903:2308:b0:16a:1b3f:f74b with HTTP; Wed, 22 Jun 2022
 08:04:19 -0700 (PDT)
Reply-To: sales0212@asonmedsystemsinc.com
From:   Prasad Ronni <lerwickfinance7@gmail.com>
Date:   Wed, 22 Jun 2022 16:04:19 +0100
Message-ID: <CAFkto5smHNaF1-vVzk=Z1eS16uFFKvVSRfL+KNTa=bLCi1i03g@mail.gmail.com>
Subject: Service Needed.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

-- 
Hi,

Are you currently open to work as our executive company representative
on contractual basis working remotely? If yes, we will be happy to
share more details. Looking forward to your response.

Regards,
