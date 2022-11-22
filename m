Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0811063357D
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Nov 2022 07:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiKVGvI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Nov 2022 01:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiKVGvH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:51:07 -0500
X-Greylist: delayed 592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Nov 2022 22:51:06 PST
Received: from host.themysteryshoppersuk.biz (themysteryshoppersuk.biz [185.31.160.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFD6E21267
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Nov 2022 22:51:06 -0800 (PST)
Received: from themysteryshoppersuk.biz (ec2-35-93-138-106.us-west-2.compute.amazonaws.com [35.93.138.106])
        by host.themysteryshoppersuk.biz (Postfix) with ESMTPA id 3DC02114A96B
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Nov 2022 09:41:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 host.themysteryshoppersuk.biz 3DC02114A96B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=themysteryshoppersuk.biz; s=default; t=1669099263;
        bh=mrHJ7CtswN+CMn68o2+p/Ow4rHnZkimc6jIH+X2JuwU=;
        h=Reply-To:From:To:Subject:Date:From;
        b=NoE+h2bsu3STlHsE7lh5PJL148G7Oc0wlnT1pFa3CeAigdrNCa2yeIwyMUNxz6VNl
         GkAqQoX2YyGmCfz7c6oomq7PAO2yRp7nvqONVZtStSEwe/GppR/4yfT7/KHAZrS6L3
         PzSoYpswH3TUtGjuUE8ZWQdy87sxR5EGD+304Xzc=
DKIM-Filter: OpenDKIM Filter v2.11.0 host.themysteryshoppersuk.biz 3DC02114A96B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=themysteryshoppersuk.biz; s=default; t=1669099263;
        bh=mrHJ7CtswN+CMn68o2+p/Ow4rHnZkimc6jIH+X2JuwU=;
        h=Reply-To:From:To:Subject:Date:From;
        b=NoE+h2bsu3STlHsE7lh5PJL148G7Oc0wlnT1pFa3CeAigdrNCa2yeIwyMUNxz6VNl
         GkAqQoX2YyGmCfz7c6oomq7PAO2yRp7nvqONVZtStSEwe/GppR/4yfT7/KHAZrS6L3
         PzSoYpswH3TUtGjuUE8ZWQdy87sxR5EGD+304Xzc=
Reply-To: contact@themysteryshoppersgroup.com
From:   Mystery Shoppers <contact@themysteryshoppersuk.biz>
To:     netfilter-devel@vger.kernel.org
Subject: Mystery Shopper
Date:   22 Nov 2022 06:41:02 +0000
Message-ID: <20221122064102.7B8E8FDA7B29E820@themysteryshoppersuk.biz>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FROM_FMBLA_NEWDOM,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_LOAN autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.8 FROM_FMBLA_NEWDOM From domain was registered in last 7 days
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I would like to introduce our company as Shoppers Bay Ltd We=20
conduct research on various businesses to improve connections=20
between professional service firms and their client organization.=20
Our company is currently in search of =E2=80=9CRETAIL EVALUATOR=E2=80=99S=
=20
SERVICE=E2=80=9D in your area. The job entails store evaluation and=20
comments on customer service impact in your local communities by=20
helping stores, restaurants, and banks become better places for=20
consumers like you to visit.

A mystery shopping assignment involves independent contractors=20
posing as =E2=80=9Cshoppers=E2=80=9D. You will be paid to visit their local=
=20
brands as a customer and you would report back on various aspects=20
of your experience.  If your performance is satisfied with the=20
organization, it means your point will be graded and salary=20
increases to 15 percent.

RESPONSIBILITIES:

1. Assignments are to be completed quickly as possible, but=20
flexible.
2. You need to be friendly, reliable, have a good attitude,=20
Effective time management skills, a self-starter and pro-active.
3. You will be able to multitask and be able to work as a team.

COMPENSATION/SALARY BASE: As a =E2=80=98RETAIL EVALUATOR=E2=80=99S SERVICE=
=E2=80=99,=20
You=E2=80=99ll get paid for every business you visit. Each survey takes a=
=20
maximum of 30-45 Minutes to complete and you=E2=80=99ll be paid =C2=A3400 G=
BP=20
for every survey completed, No Sales Involved and No Experienced=20
required, I promise you this will not inconvenient your present=20
job.

We will furnish you with all expenses needed to execute your=20
assignment and the questionnaire to fill for your report. We=20
understand if you are not seeking additional opportunities at=20
this time. We are also open to any referrals that you may have.

To ensure proper consideration, please fill in the information=20
below as completely and accurately as possible. Come join our=20
team. You=E2=80=99re going to like it here!

First Name:
Last Name:
Full Address:
Mobile No:
Email:
Age:
Present Occupation:

Thank you,

Eileen McCoy.

Secret Shoppers llc
