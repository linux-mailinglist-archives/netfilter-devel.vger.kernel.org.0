Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356D779296A
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Sep 2023 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351907AbjIEQ00 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Sep 2023 12:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353824AbjIEIT2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:19:28 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070F1CCF
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Sep 2023 01:19:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76da0ed3b7aso140700085a.1
        for <netfilter-devel@vger.kernel.org>; Tue, 05 Sep 2023 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693901964; x=1694506764; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvUmRYKO5rN5JiKdYLn9/Xxm/soJiVGtQm650JnL3Yc=;
        b=Rsh1U5LWkGLD60egT4xH0OkFTYAdhZ9PEm8UjiAWZ2Ip5vQRRw1xGx18MGa89HvYT6
         DHnioG41PeB3MkB8Ft4Wrqqp2kjHic/Vkr/qunTIeMzVwVxM8xASTQz27lIUkjehlemV
         8hhlmR9WWRNLvf+5DEaOSg8zVsJ6dc1e3o0hPmiekrNR95zn5u2OlTodDzhAW5FoXvst
         vtI6oie/Go2kADRNvERCwQ/tj5WyItWCvOqaItC7RUWSKHX1Jy68bxHNnuEfs4fh7/gu
         3DkWJuriwsFIhQtQN+dSHz9r/brcNOoN1uxEnXTsFI93qPjm9f/GoLz132bzGfSth5g7
         +kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693901964; x=1694506764;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvUmRYKO5rN5JiKdYLn9/Xxm/soJiVGtQm650JnL3Yc=;
        b=VGETEdR8ddu8g3Hh5zAlG1TLszj25SJ3c3knV0aSd1Z8grNIXzJVUAVw00XQKohygQ
         Lr0Doh70I95NXnh3/iPftijL8LF20EKlny4zfFd2IGFaswt54S+ghJ4KKfK8RQpXZWfv
         8hcgjEQ4/ALsH5azi61+YJQJFKxAGM6eRTKuGNt86s2PVPRkVL0Aj+6xRGHXSem5CJXM
         /nL7DOGNp12VBki8SPnY+weaDTMDMNou7vxi2YcYeLDHj2mNUX/5u9nfl2uaDdbqcsU3
         AHXlmReUOMbeGCFbYzflKHF9Mpq79m6q5dG4wYpQEQvHSa+mQq1EoulkOiaDfQp6AIO/
         qDBw==
X-Gm-Message-State: AOJu0YwJVxHa4r+LIPyqEwLVz0XFeGPGO4J4pqkpjh4phrhkvzjbrUjc
        QBpyKgK6vL10AzEGbMrDG9kZNn9DO431CPP4qH8mohLIFbsfUQ==
X-Google-Smtp-Source: AGHT+IERAX8PQb3+O/VRt2IpdT+B8+AIRhc7TR9qfBXEywqtD/tUeMqNmseulSPs3fS452xIhVN8tbhQYqX1LXl34po=
X-Received: by 2002:a0c:aa1b:0:b0:653:5736:c0b4 with SMTP id
 d27-20020a0caa1b000000b006535736c0b4mr10412089qvb.54.1693901943569; Tue, 05
 Sep 2023 01:19:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:de0e:0:b0:634:8588:8dcb with HTTP; Tue, 5 Sep 2023
 01:19:02 -0700 (PDT)
Reply-To: wuwumoneytransfer5000@hotmail.com
From:   "(IMF) SCAM VICTIMS" <smmab4668@gmail.com>
Date:   Tue, 5 Sep 2023 01:19:02 -0700
Message-ID: <CAPvhgiGb_xchv+cBfjtNXZbs3T38s2BJRqmONSNBDUeOvUkr=Q@mail.gmail.com>
Subject: Betrugsopfer
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sehr geehrter E-Mail-Besitzer,



Der Internationale W=C3=A4hrungsfonds (IWF) entsch=C3=A4digt alle Betrugsop=
fer
und Ihre E-Mail-Adresse wurde auf der Liste der Betrugsopfer gefunden.

Dieses Western Union-B=C3=BCro wurde vom IWF beauftragt Ihnen Ihre
Verg=C3=BCtung per Western Union Money Transfer zu =C3=BCberweisen.

Wir haben uns jedoch entschieden Ihre eigene Zahlung =C3=BCber Geldtransfer
der Westunion in H=C3=B6he von =E2=82=AC5,000, pro Tag vorzunehmen bis die
Gesamtsumme von =E2=82=AC1,500.000.00, vollst=C3=A4ndig an Sie =C3=BCberwie=
sen wurde.

Wir k=C3=B6nnen die Zahlung m=C3=B6glicherweise nicht nur mit Ihrer
E-Mail-Adresse senden daher ben=C3=B6tigen wir Ihre Informationen dar=C3=BC=
ber
wohin wir das Geld an Sie senden wie z. B.:


Name des Adressaten ________________

Adresse________________

Land__________________

Telefonnummer________________

Angeh=C3=A4ngte Kopie Ihres Ausweises______________

Das Alter ________________________


Wir beginnen mit der =C3=9Cbertragung sobald wir Ihre Informationen
erhalten haben: Kontakt E-Mail: ( wuwumoneytransfer5000@hotmail.com)


Getreu,


Herr Anthony Duru,

Direktor von Geldtransfer der Westunion
