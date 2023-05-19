Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAD4709736
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 May 2023 14:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjESMXz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 May 2023 08:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESMXy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 May 2023 08:23:54 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20130103
        for <netfilter-devel@vger.kernel.org>; Fri, 19 May 2023 05:23:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-39212bf4ff0so1753258b6e.1
        for <netfilter-devel@vger.kernel.org>; Fri, 19 May 2023 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684499033; x=1687091033;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=XgfaISJePzoZi4AwEfgClzPGZVT3Fj61ZvNsT4tFENlWlyaZ2mE1D7Ovp7YuXK4p8Z
         nCo/hy+3M+/lzKJBlv+0zKSDPzaXWk58QUv2+Lz7vUXTXWdvecgaAKYTr4ESSZhg6rOX
         ih9U2YuM3qyzE8lsVeiDhFY2knltxpff9DjwuaQow55sIXZFuf45NOBYx28RwsnjQGEX
         t+jbxjAPwL+qhV8B4t5KjyVhKHDOZw16FJZXOdP0vOisoDHB+0F0nvq7+v6/KWE8kAul
         bQ5NG7mCM/jCOGQZJf6vMezP65q+hcgScyRBq7O8CFiZUjs0g8IbwSWCdw5jy4jzhFVn
         UIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684499033; x=1687091033;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=HmPMef7I1VlfJNCU9WDs/kOlJBvmePjPg3bWwCOv8/3QFtNdr5Fh/YyiQHmfBNt4QI
         1OmwWJDGV1VInUZpJmbiSTlvzvSsduzu/BDzmbOlL76wbgQrPsOJuz3Ot341jTmJFjkj
         RKF94ONcOxiIFPb5ztTfofU3JHT4LSixy+NthFa0hoDOS8R9nzsv8G0WTm5yecquBzvR
         OOHBG3D93Y5O86fGg5KlAkDcpWsGU9x4Vt4PwIWTR6ek/Dxux4qDCLQnnF302sYxO9J2
         Xe+OV798tFFCZ8eGkEYhjvTUTOmww8iukfj7OPXVE84/eIdTQkYNOrGczllIRpZFHvNR
         MpCg==
X-Gm-Message-State: AC+VfDyP7MNvjVGe+DGt+96xvD1n7/nd4g4cWEs8WmB6nUjAOiZekLky
        1jmX7b2rur4XivpXIAiI/Nf3NQ/0es/ul0YB8Zk=
X-Google-Smtp-Source: ACHHUZ4pGn2nufWm++ETvvSQANFMV6fTNK7EEnCccdAXoFDT4rQvGmbkmdEDYG5xc7EejmLWwskdPc9tNlvIE+g9gmI=
X-Received: by 2002:a05:6808:28b:b0:38c:4c09:562b with SMTP id
 z11-20020a056808028b00b0038c4c09562bmr953894oic.13.1684499033356; Fri, 19 May
 2023 05:23:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:f481:b0:115:f8b:bdf8 with HTTP; Fri, 19 May 2023
 05:23:53 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <ninacoulibaly216@gmail.com>
Date:   Fri, 19 May 2023 05:23:53 -0700
Message-ID: <CAJsSN600rv4V4d_Y0vKdBe2U75-VXPP_Q9WK0wv7V5r4NqRQdQ@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dear,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs Nina Coulibaly
