Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70444196E3B
	for <lists+netfilter-devel@lfdr.de>; Sun, 29 Mar 2020 17:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgC2Pxv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 29 Mar 2020 11:53:51 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50668 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727167AbgC2Pxv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 29 Mar 2020 11:53:51 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jIaFx-0006UG-1U; Sun, 29 Mar 2020 17:53:49 +0200
Date:   Sun, 29 Mar 2020 17:53:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     jaroslav@thinline.cz
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: Suggestion: replacement for physdev-is-bridged in nft
Message-ID: <20200329155349.GB23604@breakpoint.cc>
References: <8b6e45ba8945b226e4c95e6e9a1cf2e4@thinline.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b6e45ba8945b226e4c95e6e9a1cf2e4@thinline.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

jaroslav@thinline.cz <jaroslav@thinline.cz> wrote:
> Hello,
> 
> I hope this is the correct list to post to (based on info on
> https://netfilter.org/mailinglists.html), I apologize for the noise if not.
> 
> I am trying to replace these iptables rules:
> 
> iptables -P FORWARD DROP
> iptables -A FORWARD -m physdev --physdev-is-bridged -j ACCEPT

rmmod br_netfilter

or set
net.bridge.bridge-nf-call-arptables=0
net.bridge.bridge-nf-call-iptables=0
net.bridge.bridge-nf-call-ip6tables=0

Then remove the "-m physdev" rule.
After this, nft ip,ip6,arp and inet tables will only
see forwarded (routed) packets.

Dedicated bridge filtering can be done via "bridge" family.
