Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6D374C3E
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 12:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfGYKyj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 06:54:39 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:44064 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728726AbfGYKyi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:54:38 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hqbOO-0001Xk-Qt; Thu, 25 Jul 2019 12:54:36 +0200
Date:   Thu, 25 Jul 2019 12:54:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Adel Belhouane <bugs.a.b@free.fr>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH iptables]: restore legacy behaviour of iptables-restore
 when rules start with -4/-6
Message-ID: <20190725105436.pozi3leyyur6h6nr@breakpoint.cc>
References: <f056f1bb-2a73-5042-740c-f2a16958deb0@free.fr>
 <20190725104035.GP22661@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725104035.GP22661@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Thanks for catching this. Seems like at some point the intention was to
> have a common 'xtables' command and pass -4/-6 parameters to toggle
> between iptables and ip6tables operation. Pablo, is this still relevant,
> or can we just get rid of it altogether?

Evidently this is behaviour that is relied on by some, so we need to
cope with this in -nft version too.

> > % iptables -6 -A INPUT -p tcp -j ACCEPT
> 
> On my testing VM this rule ends up in table ip filter, so this seems to
> not even work as intended.

$ iptables-legacy -6 -A INPUT -p tcp -j ACCEPT
This is the IPv4 version of iptables.
