Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E407DBD6
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Aug 2019 14:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfHAMrp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Aug 2019 08:47:45 -0400
Received: from correo.us.es ([193.147.175.20]:36586 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731341AbfHAMro (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:47:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EEEBBFB364
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Aug 2019 14:47:42 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DEF29DA732
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Aug 2019 14:47:42 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D4A53DA704; Thu,  1 Aug 2019 14:47:42 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E6100DA732;
        Thu,  1 Aug 2019 14:47:40 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 01 Aug 2019 14:47:40 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [47.60.32.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C00454265A2F;
        Thu,  1 Aug 2019 14:47:40 +0200 (CEST)
Date:   Thu, 1 Aug 2019 14:47:38 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 4/5] xtables-monitor: Support ARP and bridge
 families
Message-ID: <20190801124738.pnfo4zsypkqiaonm@salvia>
References: <20190731163915.22232-1-phil@nwl.cc>
 <20190731163915.22232-5-phil@nwl.cc>
 <20190801112050.nqig4dbncyx4gfdz@salvia>
 <20190801120048.GS14469@orbyte.nwl.cc>
 <20190801123040.rljiffbbux3bajls@salvia>
 <20190801124107.GT14469@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801124107.GT14469@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 01, 2019 at 02:41:07PM +0200, Phil Sutter wrote:
> Hi,
> 
> On Thu, Aug 01, 2019 at 02:30:40PM +0200, Pablo Neira Ayuso wrote:
> > On Thu, Aug 01, 2019 at 02:00:48PM +0200, Phil Sutter wrote:
[...]
> > I think users will end up using --arp and --bridge for this. I myself
> > will not remember this -0 and -1 thing.
> 
> That's correct. So I guess changing cmdline flags to -a/-b makes sense
> either way.

In the rule side, getopt_long() is already pretty overloaded, just
double check these are spare.

> > Feel free to explore any possibility, probably leaving the existing -0
> > and -1 in place if you're afraid of breaking anything, add aliases and
> > only document the more intuitive one. If you think this is worth
> > exploring, of course.
> 
> I would omit the prefix from output if a family was selected. For
> unfiltered xtables-monitor output, I would change the prefix to
> something more readable, e.g.:
> 
> 'ip:  ',
> 'ip6: ',
> 'arp: ',
> 'eb:  '
> 
> What do you think?

Probably use the long option name, which seems more readable to me:

EVENT: --ipv4 -t filter -A INPUT -j ACCEPT

I like that the event is printed using the {ip,...}tables syntax.

Thanks!
