Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4298863C92A
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Nov 2022 21:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiK2US1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Nov 2022 15:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiK2USZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:18:25 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7804995A2
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Nov 2022 12:18:24 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id bi15so7443785vkb.11
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Nov 2022 12:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=WUrteBJor5iabiHyu/h6Kh1u4hc7rm0OlJ8vin71QE2YIa0sJuk9tz3TYeTbZH6MOw
         DHr03XIRbLSiM2j9OJYY2lpizwycNUBUgNXMuTjZKcPBoim/7K3vCnpqUXqRUm3Oz6qV
         yuPQMKuDKEz68OzjAOFqca02jt9zWWPqM/jXvh/boC5T4Q/BTJvAh5YSSGf26Y0E3zH2
         TOxXYoy9AyaeJoR+6UfvmNSKYo8KvwE3lEJFRtKX0JOrYu4t41KY6iIl3QeD37rm0M0r
         GKhOeJf70G4rIdx1bRLUwjwlsm1vS6oiNXUHApy2eKB8ro/QmllrbIJgRnYqIWTgsrYI
         Z69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=sPxs2UR+BiwWGtioDd4eWsqwjZOsYv+lhgnFmDp/8aa7bkrC4BoBcGMB9kgjGW0tdo
         uxh2HWUwlI0xryFwssJhmuavzn3EojkYDKsyGnIJmEN0R9cqOyQmQ/w2cuZXHw5dC+d4
         dKmtJT/ikSAgk727YxLko8zYYJrXI4//8WiJFq4uMq9zomszNq1jUIAglJZFK23O2CyB
         r3/vP5jBYOcQKDN73dO3Hv60EO8aNPOmDF4P1CQeS9sKWYE66+PEMIV0TyDN3yB+iPKu
         jIhTKawD1JpkvoSGlwBlaRrPgvePGVh40kwhdRFuK5yHFYw0U9Xvf5pKQYJ1A/RU1v6J
         v3oQ==
X-Gm-Message-State: ANoB5pnblU251wPmfKKoLVvtG80/9Px0ZGM+azPusK/wALc5BQP/BOX/
        6CIONrmzCoCp+JmyC0VRCcGaVXx+kVazzc12UXk=
X-Google-Smtp-Source: AA0mqf5ayvorfcB9j/U/Td0EzpinEGhlLui08ksxXYMGSLvmhH0ipr59y3ATqQaK+cma/0LkwLplgR+RKZ5i3q31gWU=
X-Received: by 2002:a1f:2b8e:0:b0:3bc:5598:2096 with SMTP id
 r136-20020a1f2b8e000000b003bc55982096mr24704898vkr.36.1669753103355; Tue, 29
 Nov 2022 12:18:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:dd17:0:b0:32b:c965:6e63 with HTTP; Tue, 29 Nov 2022
 12:18:22 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <chiogb001@gmail.com>
Date:   Tue, 29 Nov 2022 20:18:22 +0000
Message-ID: <CACHdXT21_0OLyG4p5xAiMBzF1BibPBSEd-mm85a3qGko1CZ=tg@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
