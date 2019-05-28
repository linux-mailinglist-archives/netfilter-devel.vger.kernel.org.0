Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70BC2C371
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 May 2019 11:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfE1Jni (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 May 2019 05:43:38 -0400
Received: from a3.inai.de ([88.198.85.195]:40408 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfE1Jni (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 May 2019 05:43:38 -0400
Received: by a3.inai.de (Postfix, from userid 65534)
        id 390CC3BACCB5; Tue, 28 May 2019 11:43:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.1
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 7ED543BB6EEF;
        Tue, 28 May 2019 11:43:28 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: Avoid unnecessary rebuilds of iptables
Date:   Tue, 28 May 2019 11:43:25 +0200
Message-Id: <20190528094327.20496-1-jengelh@inai.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


 .gitignore                                     |  1 -
 Makefile.am                                    |  8 ++++++--
 configure.ac                                   |  1 -
 include/iptables/{internal.h.in => internal.h} |  2 --
 iptables/ip6tables.c                           |  4 ++--
 iptables/iptables-restore.c                    |  4 ++--
 iptables/iptables-save.c                       |  3 ++-
 iptables/iptables-xml.c                        |  6 +++---
 iptables/iptables.c                            |  4 ++--
 iptables/xtables-arp.c                         |  4 ++--
 iptables/xtables-eb.c                          |  4 ++--
 iptables/xtables-monitor.c                     |  5 +++--
 iptables/xtables-restore.c                     |  4 ++--
 iptables/xtables-save.c                        |  5 +++--
 iptables/xtables-translate.c                   | 10 +++++-----
 iptables/xtables.c                             |  4 ++--
 16 files changed, 36 insertions(+), 33 deletions(-)

