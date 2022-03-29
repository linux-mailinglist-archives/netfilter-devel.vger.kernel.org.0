Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5E4EB5B1
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Mar 2022 00:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiC2WQE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Mar 2022 18:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiC2WQD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:16:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B77187BB5
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Mar 2022 15:14:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i4so7915909wrb.5
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Mar 2022 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=d4S8QaDgxQlvsc2u3XO+AIgXTYBAIsd9U0A7SaaCSvTo4whkVMgBP0hXQZ9FsTu+wR
         mf9SUJTrvJkilcZeCkvvuayt/8S5LEmW5SC6d/xFYK6C9SaEFG3x9rXIcudlDSA/V13a
         22mUfuSmiofuuJeRoWrGFBf3GlhLAo85ReYRXe97fKreiJ84Os0PwzgzV1UYizmB8y+0
         p5QbIVkWQh0nKrnmtTSR6KmraPhz17XcVB4o8o+sBEwH14n+AA2Dw4UAkor6RoSxpbg+
         aKybqHK5hztF3Up6+9dt9IQJe3jNu/Fz7Doos15XS0dhPfubdcetH7XrDqyELP1zKbT5
         C5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=DoaV+ye+rfL0EHWLY2Bc3qE2Do3crtJ6eZeRgf5/0GvVw0ZFONIsKG/U72JyJ2L927
         BuXSPZ59VC5ZQySWlMlXAQbVT/Nd4hrfVaZtV9lE9CfrXIu/EgT8a+dzMnlqXFU7LjL8
         LCYzxIgqsogxgZGjlBkbmvgWqhSBFx1OFByEdhQ/KaLpTXoZcuNZxtmzsaob/PGtn/5J
         nL8JjCq7DmiDWHwujDQ77SxXY9DfA6TvdhZG2yrCqxQzvBV9s4fAxnfMHORF3zs/BJft
         qj+2fH4PenXJzzqP094ua3xrTCcuvqXnbJBDchCdnK4+Dpr13AD22BB7wxH740f8MJ/c
         68zg==
X-Gm-Message-State: AOAM532rB3ef4LPyixrO+eCW10+FvC8nJvvgiRVy/HiRHDSqFKFXgjDY
        9wI94lLzhJZSMcmBcbm4RDk=
X-Google-Smtp-Source: ABdhPJw7Cy8neytEBjxk8BY8n3y/XC7G0EDEKChQ6CF4wlEsu/yuf0isY0yN4OSfn2DYTGdVQPu9Vg==
X-Received: by 2002:a5d:5849:0:b0:205:8206:86d3 with SMTP id i9-20020a5d5849000000b00205820686d3mr33541217wrf.327.1648592057072;
        Tue, 29 Mar 2022 15:14:17 -0700 (PDT)
Received: from [172.20.10.4] ([197.210.71.189])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b0038cd93a59e4sm3424443wmq.28.2022.03.29.15.14.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:14:16 -0700 (PDT)
Message-ID: <624384b8.1c69fb81.3d6f1.e490@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:14:08 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
