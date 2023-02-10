Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D979E691DF2
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Feb 2023 12:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjBJLQB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Feb 2023 06:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjBJLP6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:15:58 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5795275
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Feb 2023 03:15:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id co8so975797wrb.1
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Feb 2023 03:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fVFyID1zoACnzbfY7COoe5VRvVM558UwEhCLqkIS/0k=;
        b=GofXtuYfo2h+3Bpklc5nS426qbgoF5K35XUs1HzMnh6KgUZTw9E+SiRw4peXIQsX+C
         TU9FGkMUxSjU5SgW6PK8wECvQrRcVxMIzhnWq8Y5R/B8yqEzeBej3S9a7oeC10J4OUNI
         7t90KcPQaZB2rYQgDDYrx95bx1/dULXOoycCUMCsIPcr+ScqLE0O4zAl3PULu2HOFZta
         VMvwj2SuwqpAia3HwYGaZsHUSlfUAMl0NPjfSJe91oKKlwcvvflweuuQeZYo4k9xSHHG
         qLVhAYTxLc5tHS5a8x0EXN3ZT7GaND0GLuinJm29/yaT1iolgxkH0SRUWVekkHoV77cj
         MZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVFyID1zoACnzbfY7COoe5VRvVM558UwEhCLqkIS/0k=;
        b=JpUqrnh6oNPUH07onN3/xb4V+949Vh0AvuFHgB0zbf3H6iDxuhUvpSdxDpaF2HYts8
         TwlPOugq5v0jLItfyWHb8X/rofaG4Aeo/+niRS9q+o9GAwC9rHpY4UY25iM51T+PlZik
         JLaCmyhq3PRHRa9bg7akyt8STTmIcR3YnsIWzNHy6i35zCpCHRnXTKDIPWCutww12/N2
         SubJTeR5uoTLND3gOpyIeXwDIs3y1vLhKVqEf6Z7L6crLEjfR84PiCesKce3tMUQvsK7
         8iGJqn0KZzc4MR3udflH4/x0Zjm7JsihtjyWs7XfAqTyVTKzphCKKCf43F91F1Me76ou
         JaVw==
X-Gm-Message-State: AO0yUKXVUbWHUXgGCSmb4wwUeB+3fI6uR5Ehq/Y+NIq8ZZ1NtcF1bs5Z
        +RXjTO1hMbFRS4QfBfcgpYUf551TJPrmVOwn/g==
X-Google-Smtp-Source: AK7set/UoSOC7PWNF8U1iML5axiLZOm73vR7Qp5u8Z2J1wwK2qUUUKVKZDpOJks0TeRvkMLAAjnCNC/2uS+taLqhtNY=
X-Received: by 2002:a05:6000:1106:b0:2c3:f0ec:68ab with SMTP id
 z6-20020a056000110600b002c3f0ec68abmr728819wrw.54.1676027748316; Fri, 10 Feb
 2023 03:15:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6020:bc84:b0:25e:50:ca58 with HTTP; Fri, 10 Feb 2023
 03:15:47 -0800 (PST)
Reply-To: abraaahammorrison1980@gmail.com
From:   Abraham Morrison <officeoffice718@gmail.com>
Date:   Fri, 10 Feb 2023 03:15:47 -0800
Message-ID: <CAEgLm42xNhecTU7dCCi6vDxRarwj8e0-r=nRQPsRYMveK8+YYQ@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:431 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2814]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [officeoffice718[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [officeoffice718[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abraaahammorrison1980[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Oppmerksomhet takk,

Jeg er Mr. Abraham Morrison, hvordan har du det, jeg h=C3=A5per du er frisk
og frisk? Dette er for =C3=A5 informere deg om at jeg har fullf=C3=B8rt
transaksjonen vellykket ved hjelp av en ny partner fra India, og at
fondet n=C3=A5 er overf=C3=B8rt til India til bankkontoen til den nye partn=
eren.

I mellomtiden har jeg bestemt meg for =C3=A5 kompensere deg med summen av
$500 000.00 (kun fem hundre tusen amerikanske dollar) p=C3=A5 grunn av din
tidligere innsats, selv om du skuffet meg langs linjen. Men likevel er
jeg veldig glad for den vellykkede avslutningen av transaksjonen uten
noe problem, og det er grunnen til at jeg har bestemt meg for =C3=A5
kompensere deg med summen av $500 000,00 slik at du vil dele gleden
med meg.

Jeg anbefaler deg =C3=A5 kontakte sekret=C3=A6ren min for et minibankkort p=
=C3=A5
$500 000,00, som jeg beholdt for deg. Kontakt henne n=C3=A5 uten
forsinkelser.

Navn: Linda Koffi
E-post: koffilinda785@gmail.com

Vennligst bekreft til henne f=C3=B8lgende informasjon nedenfor:

Ditt fulle navn:........
Adressen din:..........
Ditt land:..........
Din alder:.........
Ditt yrke:..........
Ditt mobiltelefonnummer: ..........
Ditt pass eller f=C3=B8rerkort:.........

Merk at hvis du ikke har sendt henne informasjonen ovenfor
fullstendig, vil hun ikke gi ut minibankkortet til deg fordi hun m=C3=A5
v=C3=A6re sikker p=C3=A5 at det er deg. Be henne sende deg den totale summe=
n av
($500 000,00) minibankkort, som jeg beholdt for deg.

Med vennlig hilsen,

Mr. Abraham Morrison
