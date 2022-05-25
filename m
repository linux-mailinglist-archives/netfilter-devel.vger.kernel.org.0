Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DD45344F8
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 May 2022 22:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbiEYUfQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 May 2022 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345100AbiEYUfO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 May 2022 16:35:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7133CB0D0A
        for <netfilter-devel@vger.kernel.org>; Wed, 25 May 2022 13:35:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m20so43914132ejj.10
        for <netfilter-devel@vger.kernel.org>; Wed, 25 May 2022 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jF4MxsPSKKSAh34A0y7fWqFeFSCCDQ9NCjS0um7aELU=;
        b=VocQsthp4kr71VkA6y/yGQ8r7PzvrX8S0kDee5bYwGXinCWOEWzdKcvX7qcajQQvGu
         FO46yq2dNFoJHRXEn1midlW/oMmMAE/tH12+3dL6eCDwk/aXnzFoZCoXYF7Tr2XdXAWF
         A14RSJ7nwmV5Qn/QoKcAQnffjrruBdZQi5J4nFon7T4xNFyrzXHYChC8X8Q7vV/O0l3G
         Z6kSQfj+bwrSd9gDnvGTu2FkqtNFM/AKycKz8EdP1s6K6YZjA9EDOUYTL090EYLi69Jx
         FPI6DZKF09Tmz0hCD4UJidqzxCTHlRf+WFpdOUsf3yKhZ6hLlPG8x7UCYJ8ts18QQbpn
         zECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jF4MxsPSKKSAh34A0y7fWqFeFSCCDQ9NCjS0um7aELU=;
        b=7xcw2U9yTFaYrrW5pJt7fodxf9i/uE834XTH9/2ISh13vKA6rl9g4UuMoCzs2dGFio
         2oil4Z9TfCWSiXZOLEO7+BKv2nzMcPBXSzksqmzoskSL2cjfKOVDv6QLhXOY7ozmKVZ2
         DQylEWZvz1AfKO19MLBVOGpigmMcTDrhNkL7LmlJ01eQPoGeWEWM6Paq54Y4ti05fXm6
         XlOnfA3ms1ytOuFX3/ZVbMFziISY9mn4Zaze5PPu1E/LIuA14jnS2onYJTURtDRAOxxP
         6mtueUWwxq+O3DStrvfwoK9QdbxNz+/y1FJg+YVoHlnkC8S/LQFzEHgdNrc18hbLQMK+
         W/7Q==
X-Gm-Message-State: AOAM5313qqHnvornKycmvUISnKYOrIN2KOBDESgYf4SzyIvJK1p0na1X
        GDB42QQAx0cSP7wo1W8xrch32sg6Cu79xXtMgiQ=
X-Google-Smtp-Source: ABdhPJydmv+bbHARzEgvyIwdIWejEqbES0XbtJbkAtabvPybUWLA8/SV0kCjBlZCGBxZXSvZwXoaS3LA/pCN6q+ewUw=
X-Received: by 2002:a17:907:7242:b0:6f5:2904:5354 with SMTP id
 ds2-20020a170907724200b006f529045354mr32161701ejc.452.1653510911898; Wed, 25
 May 2022 13:35:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a26b:0:0:0:0:0 with HTTP; Wed, 25 May 2022 13:35:11
 -0700 (PDT)
From:   Luisa Donstin <luisadonstin@gmail.com>
Date:   Wed, 25 May 2022 22:35:11 +0200
Message-ID: <CA+QBM2rd1NojOmQ247cmwY+sk9R4hWU6pMA3fqAMrkMrBDEUUw@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Luisa Donstin

luisadonstin@gmail.com









----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Luisa Donstin

luisadonstin@gmail.com
