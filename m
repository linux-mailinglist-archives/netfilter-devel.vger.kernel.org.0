Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96270642DF9
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Dec 2022 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiLEQy2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Dec 2022 11:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiLEQyH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:54:07 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE24D22B1B
        for <netfilter-devel@vger.kernel.org>; Mon,  5 Dec 2022 08:52:09 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id h10so10002207wrx.3
        for <netfilter-devel@vger.kernel.org>; Mon, 05 Dec 2022 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4WPtqOs6pYDke8VCfpzwsIX+8zN33o8tLS2XMy/lFU=;
        b=Nz/XnD4mcDMeaNKvgn5SepSfnKJynYd26drKZSYqboxpk0mcd5h0M5MWDmG0I6FZpn
         IDHA769G80+cd5u+Zmqekp0R+NXf5LmZJoCZp0XK9jx9VuYwYzIBi9xIOcbsDhGcj1Pd
         krbFHXqclLN1r+Mayn+BE8R1gjyDOEq1MV+zAzEOuiJb2YIVnc0t4nb3usZ8uGjTI8dK
         sTtdgIyfCKkSC/izZUcu4RvsFWLjjxaW6/ss6MJiX4bftw8G0RLiZM/3FaLSeqdFHXvz
         CxmS2PE0me5rnl9OcIWiGt6PsXvvY6NLNJhtRhi6ylB7pXoTTttlwIidjvVJzd7lc8L1
         jryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4WPtqOs6pYDke8VCfpzwsIX+8zN33o8tLS2XMy/lFU=;
        b=pjZkxrlCSpO6krAILB/AiXWZLxr4HDcqNB2Qmhj5ehP8H64mjWIWy3040/2BSonOwx
         eVrkqpRQkBrxJ3xBjmOTLtmXsAG/G4NlNByQs9tDq2vMqfUsxE5gheKe0uYZKjHZGAsv
         csRUAgcM26DI80Gayrw1iYsQIpCFinm4bkhEwWxw/LghyK1t/Rx7+hTrBYqImgFd+gWm
         7Hyyscs9zFVaTJEmB7FxhG6TpGAsMFa2ZmXbFVPlAaCpms8OVkp0yBexDYmqs/kyNkMu
         oBNgJIl+5rHUkyZaAhJRbdLz+U73LSpZ+GKjym9nIxxvDk7lRssgWq6jPMQO5yWZqraJ
         PWHA==
X-Gm-Message-State: ANoB5plgT/Oog8y9VKyWzklcrZ3NoRCuR0Gax/uVRKv75d1YhAJMZjv7
        bSSIbQoMeXc9ttqO8WwPFRu9jBV0nsTKVCO/vb4=
X-Google-Smtp-Source: AA0mqf57ZviGMAUJa40HplUSZdKC7mbF+XXAbJoRnDUf2Qz4Yf5RFaBHZJg+SjGtVoQZHDYW2qXNUWKAlwL9001hH0I=
X-Received: by 2002:adf:ecd2:0:b0:236:6fd9:9efa with SMTP id
 s18-20020adfecd2000000b002366fd99efamr48509119wro.101.1670259128223; Mon, 05
 Dec 2022 08:52:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:5c1:0:0:0:0 with HTTP; Mon, 5 Dec 2022 08:52:07
 -0800 (PST)
Reply-To: phmanu14@hotmail.com
From:   Philip Manul <zagbamdjala@gmail.com>
Date:   Mon, 5 Dec 2022 08:52:07 -0800
Message-ID: <CAPCnorG-XD6nj_eG31hfg5pq-C-zHrVQ38=pSaWUBnnuXUV5yA@mail.gmail.com>
Subject: REP:
To:     in <in@proposal.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

--=20
Guten tag,
Mein Name ist Philip Manul. Ich bin von Beruf Rechtsanwalt. Ich habe
einen verstorbenen Kunden, der zuf=C3=A4llig denselben Namen mit Ihnen
teilt. Ich habe alle Papierdokumente in meinem Besitz. Ihr Verwandter,
mein verstorbener Kunde, hat hier in meinem Land einen nicht
beanspruchten Fonds zur=C3=BCckgelassen. Ich warte auf Ihre Antwort zum
Verfahren.
Philip Manul.
