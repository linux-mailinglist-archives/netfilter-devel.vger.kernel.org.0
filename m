Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1BD81AB
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 23:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbfJOVRq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 17:17:46 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:11022 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfJOVRq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:17:46 -0400
Date:   Tue, 15 Oct 2019 21:17:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1571174263;
        bh=p3+j7+Gqr/FtOtuL1o9w6KsJVZGnoMhqv1A693If1Lg=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=R9F0aXjDlTxKlPEAs4SpIN6ajfI3Yc5L5Ejh4Kt+nRrmZbMBENF0O2FFTV3CMFkSR
         yRd75dAOOSzcUQ1K9h3+9nWZYlHhnSGVSMH9Xk0Xfh7C3E/VGYis4B9SrxFe24APxl
         lVzswJrd2XW5dxn/Dt+ynxW3OedzdDUD2OgPAx3A=
To:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
From:   a_hungrig <a_hungrig@protonmail.com>
Reply-To: a_hungrig <a_hungrig@protonmail.com>
Subject: [PATCH] nfnetlink_cthelper: make userspace conntrack helpers with priv data work again
Message-ID: <i1P7xDy04ZUlF7D-m77iaXyon7w4xX3QJP3V3QlqUkfqDCVsSMhzty0ILwQ1_78m4FvM7JogSLOnTG-oC2y55dPYZQVo5IyefRDvkr4UI3Y=@protonmail.com>
Feedback-ID: dvT56YDfcW2mtX4j_-_2Gio-2xcuEARDzckO5VNcfcxNhLZ9f3OQrQFdVc7i7WG8Mo1-dohMRoRX7ckPIeMXPg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

had trouble getting the userspace cthelper for ftp working, tracked down th=
e problem to incorrect length and incorrect params to nla_memcpy() when han=
dling the helper's priv data in kernel.

--- net/netfilter/nfnetlink_cthelper.c.orig     2019-10-11 18:21:44.0000000=
00 +0200
+++ net/netfilter/nfnetlink_cthelper.c  2019-10-15 22:00:21.159986725 +0200
@@ -106,7 +106,7 @@ nfnl_cthelper_from_nlattr(struct nlattr
        if (help->helper->data_len =3D=3D 0)
                return -EINVAL;

-       nla_memcpy(help->data, nla_data(attr), sizeof(help->data));
+       nla_memcpy(help->data, attr, help->helper->data_len);
        return 0;
 }

@@ -242,6 +242,7 @@ nfnl_cthelper_create(const struct nlattr
                ret =3D -ENOMEM;
                goto err2;
        }
+       helper->data_len =3D size;

        helper->flags |=3D NF_CT_HELPER_F_USERSPACE;
        memcpy(&helper->tuple, tuple, sizeof(struct nf_conntrack_tuple));

--

Regards
a_h
