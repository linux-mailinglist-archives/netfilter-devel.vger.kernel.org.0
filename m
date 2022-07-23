Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5757EC8E
	for <lists+netfilter-devel@lfdr.de>; Sat, 23 Jul 2022 09:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiGWHtG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 23 Jul 2022 03:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiGWHtF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:49:05 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBB4854AD4
        for <netfilter-devel@vger.kernel.org>; Sat, 23 Jul 2022 00:49:02 -0700 (PDT)
Date:   Sat, 23 Jul 2022 09:48:56 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Developer Mailing List 
        <netfilter-devel@vger.kernel.org>, fw@strlen.de
Subject: Re: iptables 1.8.8 misses -j CT calls
Message-ID: <Ytun6DBdk5Kkx4vX@salvia>
References: <124qoqo1-q45p-133s-o334-4s59r4s43p4@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <124qoqo1-q45p-133s-o334-4s59r4s43p4@vanv.qr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jul 21, 2022 at 04:20:32PM +0200, Jan Engelhardt wrote:
> 
> Bug report.
> 
> Input
> =====
> *raw
> :PREROUTING ACCEPT [0:0]
> :OUTPUT ACCEPT [0:0]
> -A PREROUTING -i lo -j CT --notrack
> -A PREROUTING -i ve-+ -p tcp --dport 21 -j CT --helper ftp
> COMMIT
> 
> 
> Output
> ======
> # Translated by iptables-restore-translate v1.8.8 on Thu Jul 21 16:18:58 2022
> add table ip raw
> add chain ip raw PREROUTING { type filter hook prerouting priority -300; policy accept; }
> add chain ip raw OUTPUT { type filter hook output priority -300; policy accept; }
> add rule ip raw PREROUTING iifname "lo" counter notrack
> # -t raw -A PREROUTING -i ve-+ -p tcp --dport 21 -j CT --helper ftp
> # Completed on Thu Jul 21 16:18:58 2022

the problem with this translation is that nftables expects the helper
to be set after the input conntrack hook.

IIRC Florian preferred not to use the conntrack template (which is
used before the conntrack object is attached to the skb). Instead, the
help is attached once after the conntrack lookup.

> Expected output
> ===============
> An nft rule involving port 21.
