Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ECF56330E
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 Jul 2022 13:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiGAL7c (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 1 Jul 2022 07:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiGAL7b (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:59:31 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83F980493
        for <netfilter-devel@vger.kernel.org>; Fri,  1 Jul 2022 04:59:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k129so1193093wme.0
        for <netfilter-devel@vger.kernel.org>; Fri, 01 Jul 2022 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=1LmHfrVUsoP6uqLoU1GlAUm94c+CNlTPsuPWJcryaOY=;
        b=Zp/4LvliwvM2zCVNtjVCJYwiu2LZt7SKK++5W6XxWlxEOuL2wOetCuGxQJoRd0oKy1
         ApBEjjeKG+YoUnmYruMbqtDAmOy1n8iCC1fp4Y5xglGzl/vS8kFQsm6jDmTxpMceRZzd
         G9QxrzRFb20zwjbNoyVMo4dtTSJ7guxxFL3Zl2mfQx4HqjeL/RCCuGyTTwSoEEsFUDXu
         Epe3ag6mbVHSBogGFQ3uUBbY22MzaF3ctKW3OzlTTlvIXg2+ds7vY5P7ALa297Zthqcl
         M5ZXQvGncTDRIlp5qKPO/ZcQhK9pptee2xRttaiKmsfSiGVuTKkw7OZ4po3de9Gbf7jT
         uy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=1LmHfrVUsoP6uqLoU1GlAUm94c+CNlTPsuPWJcryaOY=;
        b=w09Dx3v095VUHNiwQy1QnhkSxIBVI7QpOYb1FiUEo/C69bZGAio0XntqrQNZYyLTh5
         iyT3ncrd1EYEpJ3jZUvnjwMpPju3KG27qz8gRO6R67UIHeqFyJnY2Nym+70rS1/MUiVv
         FJ2MIyfS9jmgDnznREWSwynnjVOsGfkw5FPvhX5+UGkJZeAatCRB4OqdCn36xFNB/mHe
         SyXGUWSdzX7mTYX43K0uuPLoJJF/DE4r6BEnGaHbw8d5RfMcO0u+06EIqepwS64x4HFc
         r8uORNpKFB0QfoyVFfSF+pB4D+YVp/V1XUgLPGxrzGhs4DWpG97iyQZ1a6HiBvVWMeaZ
         th1Q==
X-Gm-Message-State: AJIora9Rg8huc3Ax1MROfYyaHQddq0qNitBgToQz6IQoE9hA70I13g5H
        KUcm8rbmeLCcWG5MMdjjiR0wdkteOZ/Q7kGDER4=
X-Google-Smtp-Source: AGRyM1sEbQdIW0hD29jVIMYpw8/fQ1H0leCYlDyKJcnVIZOcj9yXx+zcroFNpAWNMzI6jFhzj0+mFbEHamnHUANv35A=
X-Received: by 2002:a05:600c:2251:b0:3a0:4fb3:32d3 with SMTP id
 a17-20020a05600c225100b003a04fb332d3mr15399355wmm.204.1656676769376; Fri, 01
 Jul 2022 04:59:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:584e:0:0:0:0:0 with HTTP; Fri, 1 Jul 2022 04:59:29 -0700 (PDT)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <lawyerokonesq@gmail.com>
Date:   Fri, 1 Jul 2022 11:59:29 +0000
Message-ID: <CAHuN8_SanhUfGMdOwkc=XgwmmzFoe47jwjqGCU__fHcsGcS8Uw@mail.gmail.com>
Subject: Did you receive the email I sent for you yesterday morning?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Did you receive the email I sent for you yesterday morning?

Best regards,
L. Ken
