Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C774857CD33
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Jul 2022 16:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiGUOUj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Jul 2022 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiGUOUi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:20:38 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C8920BF6
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Jul 2022 07:20:33 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 685625872649E; Thu, 21 Jul 2022 16:20:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 6621260C26F17
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Jul 2022 16:20:32 +0200 (CEST)
Date:   Thu, 21 Jul 2022 16:20:32 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Netfilter Developer Mailing List <netfilter-devel@vger.kernel.org>
Subject: iptables 1.8.8 misses -j CT calls
Message-ID: <124qoqo1-q45p-133s-o334-4s59r4s43p4@vanv.qr>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


Bug report.

Input
=====
*raw
:PREROUTING ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A PREROUTING -i lo -j CT --notrack
-A PREROUTING -i ve-+ -p tcp --dport 21 -j CT --helper ftp
COMMIT


Output
======
# Translated by iptables-restore-translate v1.8.8 on Thu Jul 21 16:18:58 2022
add table ip raw
add chain ip raw PREROUTING { type filter hook prerouting priority -300; policy accept; }
add chain ip raw OUTPUT { type filter hook output priority -300; policy accept; }
add rule ip raw PREROUTING iifname "lo" counter notrack
# -t raw -A PREROUTING -i ve-+ -p tcp --dport 21 -j CT --helper ftp
# Completed on Thu Jul 21 16:18:58 2022


Expected output
===============
An nft rule involving port 21.
