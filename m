Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214FE59C0E6
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Aug 2022 15:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiHVNrU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Aug 2022 09:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiHVNqQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:46:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E9B26576
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Aug 2022 06:46:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d21so1973255eje.3
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Aug 2022 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc;
        bh=YCJGnMS50DbBnLJT+cooF9KF24oe4jUlHxI27gRwPE0=;
        b=fRjjOIXOuKucsllLo4ZI+amPRF/mjiL0+i2ZOc+sb0L1V58dG4p+Dgc1QscJbYQl9h
         GGDIdaiIE0L2aI+F68y7DVWJUBCJH4yWUXoeYiXyj03FHiJHGLTHa9jreS0DutvREiUG
         ZKk3v926+YKUTTFdpaFJUuVqUBmbd5qvyRAeUC3ch2qNbExu6MQHMAOmVciawBd6XNjR
         x5wjPv9NerJqPFuX/yAcK/OjzvijnvN0kC2JEzFMJBckmwPC3GZ+rq1F663AztLpFiJ2
         q9DntBLu3ATyl5M3nlkhmk8O+vTJQtmb3Onc48LcGglPEMhpkxipr3aTrBmxRxYr3j3+
         gP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YCJGnMS50DbBnLJT+cooF9KF24oe4jUlHxI27gRwPE0=;
        b=TnR1pCd6wa8wYWRaFdABWKWpJBt++cQBO3Uk3n8snWhBVN6gfyla9ZHZmRl4mm2bBq
         VZ7cCB9w8e7yxrQM4bbZL36ZtlROkUaEYOhCYk732gH0ONAiNoT1vpVjVnu4n6aVOvns
         gMb7858R1O6jZBn4VEd+uP4IJ7e7FutcRG+kkXs0FLXNCMcIGF9JGqQd1VxbOXH1MAZS
         +xGO/pkJyuRIgspR29clbI8qoJQhIJOkSfC8yB+n+9oH8Q1C8YjtaSfmNihyjgmgWFK4
         DDfbpSwgyOcCchWvSShabSDYOLTLu+uYdK1fbaZmxtcnHcAqes/e7hXV9hqOCLzruyZ+
         Ufjw==
X-Gm-Message-State: ACgBeo04g5fbE6oxstu+NvoKRdC78702cJVKJUeQmRGuSGI8Jv63iQhH
        M0HYWxMtxM+AK/3K65u/x4AzNwaMZzsq/4TnIQ==
X-Google-Smtp-Source: AA6agR5I9t2R0VDqNkK5lrl8SQSE4zw4NmzGtR/Y6B1occdZfpQv+HBCH/vfE7g6vB+lH3WW/cxWz4dzEwtviA5z9Lw=
X-Received: by 2002:a17:906:3a15:b0:73d:80bf:542c with SMTP id
 z21-20020a1709063a1500b0073d80bf542cmr3472769eje.633.1661175974022; Mon, 22
 Aug 2022 06:46:14 -0700 (PDT)
MIME-Version: 1.0
Sender: faithoboodia77@gmail.com
Received: by 2002:a17:906:1e01:b0:731:535e:b708 with HTTP; Mon, 22 Aug 2022
 06:46:13 -0700 (PDT)
From:   Mrs Evelyn Richardson <evelynrichards10@gmail.com>
Date:   Mon, 22 Aug 2022 06:46:13 -0700
X-Google-Sender-Auth: uG9jCzzUrfYcZ-9CJNLK2aOsHq8
Message-ID: <CAHd4WouNy=WgT3VTJE+hOYObjohA+VRPz+rT-fOUA3Bvwbsv3Q@mail.gmail.com>
Subject: Dear Beneficiary
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DEAR_BENEFICIARY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:630 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5032]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [faithoboodia77[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [faithoboodia77[at]gmail.com]
        *  2.8 DEAR_BENEFICIARY BODY: Dear Beneficiary:
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  2.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dear Beneficiary.


This is to inform you that the United Nation Organization in

conjunction with the World Bank has released the 2022 compensation

Fund which you are one of the lucky 40 winners that the committee has

resolved to compensate with the sum of ( =E2=82=AC2,000,000.00 Euro ) Two

Million Euro after the 2022 general online compensation raffle draw

held last WEEK during the UNCC conference this year with

The Secretary-General of the United Nations Mr. Ant=C3=B3nio Guterres in

Geneva Switzerland. This payment program is aimed at charities / fraud

Victims and their development to help individuals to establish their

own private business/companies.


Your E-mail was randomly selected among others to receive this Fund

through our International Micro Soft Network during the compensation

Ballot survey/draws.


Therefore, contact Engineer Account Mrs Kristalina Georgieva, he is

our representative and also United Nation`s Coordinator in United

State of America that will organize with you in Dispatch or handling

Your DISCOVER CARD to your Destination.You are to make sure that you

received the UN Approved DISCOVER CARD in your names which is in list

founds in names of U.N world list to receive this UN Guest Compensation.


We are at your service.

Many Thanks,
Mrs. Evelyn Richardson
United Nations Liaison Office
Directorate for International Payments
United States of America  USA
