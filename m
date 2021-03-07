Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6FE330002
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Mar 2021 10:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhCGJ5N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 7 Mar 2021 04:57:13 -0500
Received: from zucker.schokokeks.org ([178.63.68.96]:41239 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhCGJ4k (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 7 Mar 2021 04:56:40 -0500
Received: from blood-stain-child.wan.ruderich.org (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1.3,256bits,TLS_AES_256_GCM_SHA384)
  by zucker.schokokeks.org with ESMTPSA
  id 000000000000010E.000000006044A229.000068B4; Sun, 07 Mar 2021 10:51:36 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     simon@ruderich.org, netfilter-devel@vger.kernel.org
Subject: [PATCH 0/3] Minor documentation improvements
Date:   Sun,  7 Mar 2021 10:51:33 +0100
Message-Id: <cover.1615108958.git.simon@ruderich.org>
X-Mailer: git-send-email 2.30.1
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

while reading the nft man page I noticed a few minor things which
should be improved by the following patches.

Regards
Simon

Simon Ruderich (3):
  doc: add * to include example to actually include files
  doc: remove duplicate tables in synproxy example
  doc: move drop rule on a separate line in the blackhole example

 doc/nft.txt        |  2 +-
 doc/statements.txt | 20 +++-----------------
 2 files changed, 4 insertions(+), 18 deletions(-)

-- 
2.30.1

