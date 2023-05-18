Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DF3707D1F
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 May 2023 11:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjERJnh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 May 2023 05:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjERJng (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 May 2023 05:43:36 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A17C212D
        for <netfilter-devel@vger.kernel.org>; Thu, 18 May 2023 02:43:34 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 5614622812f47-3945180bef1so1154736b6e.1
        for <netfilter-devel@vger.kernel.org>; Thu, 18 May 2023 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684403013; x=1686995013;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jlL8pzL6NVZbuVjV4h5KPilkuQmPMJRpXcDIhZ2tX0=;
        b=ETByJ6wPpYnJWZJdzeplHcfgn8uXV34fkRc/aZgKnMDrIyG6mG0tyPrF4rXNcCdUdS
         V2JgsWugNZAk27kAVjpi39ILWvSSNTRNuISHCPwPRu8/xO//4q/eU9g8JbWuZEX2UXAe
         YBwf0bK1S2uWmtRv6hF5yInj+46ABHmad5EdNiLMRVkkDhlurjTgecc4gyT4omHEER1u
         UQRpX5onqOsirdOIDHKq7bZqBG0XUcTMUUbJqIioU4jeuTXkKRCJ4IJaPQ3Qpxl8mAZm
         HAi8CHHGiv0Yn+vs27YoiJDfDoJl6zW8qqSNM0YtgWACtkmnEuuKKEBPkRTaaWAHP7Qp
         LMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684403013; x=1686995013;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jlL8pzL6NVZbuVjV4h5KPilkuQmPMJRpXcDIhZ2tX0=;
        b=KjM4CzEdv0zEu4YYYuIxHSbwlOZCCNMhPtK3LbbgskMEVMBHN5CpboDNkkCc8pLG8P
         +aCbySxWZioiuX0UnZVuC8fXxVH81bgsTxdXYahUFUjPPH5tk/FLEMw5l4MK5GKPgAjq
         R/ZDn8m0TTHmB+hraOl7XRXfIcFNPILcM1QUY54VH3Ql4iWZ18FYr5h4Y0CgyfDPW8i4
         eEZq51tWL1FfTzZD1WyVADxsrJf/uUq+bVFJT0y1q7lIiMa4aGdk7XFyWSaNEP1Q+o09
         t/xYMyKLuWu14O8Epqox4QO8Cmjwd3t7JzXQBf26DRGrnNl3gXW8hhJc1v+Tm5M9K9jt
         3Asw==
X-Gm-Message-State: AC+VfDyMzxTKOruej/9nt2AQy7oYdHmYu6wv7JkCgP17d5Jnx3iLnjuy
        jGIi2IvnViruZHvTA8xScMuxQprMnYg6PkjrIVE=
X-Google-Smtp-Source: ACHHUZ7QLp3kB9MSKg6syG0tG8csXgQ/7TsbWjht60Rweqq7ihTKnq3E2v13ascLRtD6zLcHx7VQp7LkKTSHgOZt3Qc=
X-Received: by 2002:a05:6808:b33:b0:394:3e2d:515b with SMTP id
 t19-20020a0568080b3300b003943e2d515bmr1032935oij.15.1684403013444; Thu, 18
 May 2023 02:43:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:8644:b0:646:9742:4799 with HTTP; Thu, 18 May 2023
 02:43:33 -0700 (PDT)
Reply-To: contact.ninacoulibaly@inbox.eu
From:   Nina Coulibaly <ninacoulibaly014@gmail.com>
Date:   Thu, 18 May 2023 02:43:33 -0700
Message-ID: <CAPnh-Axc2Mu8G6iXBcPrXv86oVXvggnWbEkHz9gYHa9y8yqGHA@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you.I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
