Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0382B38D92
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Jun 2019 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfFGOns (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Jun 2019 10:43:48 -0400
Received: from mail.us.es ([193.147.175.20]:51516 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbfFGOns (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:43:48 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 809D4BAEA7
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Jun 2019 16:43:46 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6FF17DA702
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Jun 2019 16:43:46 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6DB98DA709; Fri,  7 Jun 2019 16:43:46 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EEC13DA706;
        Fri,  7 Jun 2019 16:43:43 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 07 Jun 2019 16:43:43 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B92C34265A2F;
        Fri,  7 Jun 2019 16:43:43 +0200 (CEST)
Date:   Fri, 7 Jun 2019 16:43:43 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        davem@davemloft.net, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, tyhicks@canonical.com,
        kadlec@blackhole.kfki.hu, fw@strlen.de, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com, linux-kernel@vger.kernel.org,
        richardrose@google.com, vapier@chromium.org, bhthompson@google.com,
        smbarber@chromium.org, joelhockey@chromium.org,
        ueberall@themenzentrisch.de
Subject: Re: [PATCH RESEND net-next 1/2] br_netfilter: add struct netns_brnf
Message-ID: <20190607144343.nzdlnuo4csllcy7q@salvia>
References: <20190606114142.15972-1-christian@brauner.io>
 <20190606114142.15972-2-christian@brauner.io>
 <20190606081440.61ea1c62@hermes.lan>
 <20190606151937.mdpalfk7urvv74ub@brauner.io>
 <20190606163035.x7rvqdwubxiai5t6@salvia>
 <20190607132516.q3zwmzrynvqo7mzn@brauner.io>
 <20190607142858.vgkljqohn34rxhe2@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607142858.vgkljqohn34rxhe2@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jun 07, 2019 at 04:28:58PM +0200, Pablo Neira Ayuso wrote:
> On Fri, Jun 07, 2019 at 03:25:16PM +0200, Christian Brauner wrote:
> > On Thu, Jun 06, 2019 at 06:30:35PM +0200, Pablo Neira Ayuso wrote:
> > > On Thu, Jun 06, 2019 at 05:19:39PM +0200, Christian Brauner wrote:
> > > > On Thu, Jun 06, 2019 at 08:14:40AM -0700, Stephen Hemminger wrote:
> > > > > On Thu,  6 Jun 2019 13:41:41 +0200
> > > > > Christian Brauner <christian@brauner.io> wrote:
> > > > > 
> > > > > > +struct netns_brnf {
> > > > > > +#ifdef CONFIG_SYSCTL
> > > > > > +	struct ctl_table_header *ctl_hdr;
> > > > > > +#endif
> > > > > > +
> > > > > > +	/* default value is 1 */
> > > > > > +	int call_iptables;
> > > > > > +	int call_ip6tables;
> > > > > > +	int call_arptables;
> > > > > > +
> > > > > > +	/* default value is 0 */
> > > > > > +	int filter_vlan_tagged;
> > > > > > +	int filter_pppoe_tagged;
> > > > > > +	int pass_vlan_indev;
> > > > > > +};
> > > > > 
> > > > > Do you really need to waste four bytes for each
> > > > > flag value. If you use a u8 that would work just as well.
> > > > 
> > > > I think we had discussed something like this but the problem why we
> > > > can't do this stems from how the sysctl-table stuff is implemented.
> > > > I distinctly remember that it couldn't be done with a flag due to that.
> > > 
> > > Could you define a pernet_operations object? I mean, define the id and size
> > > fields, then pass it to register_pernet_subsys() for registration.
> > > Similar to what we do in net/ipv4/netfilter/ipt_CLUSTER.c, see
> > > clusterip_net_ops and clusterip_pernet() for instance.
> > 
> > Hm, I don't think that would work. The sysctls for br_netfilter are
> > located in /proc/sys/net/bridge under /proc/sys/net which is tightly
> > integrated with the sysctls infrastructure for all of net/ and all the
> > folder underneath it including "core", "ipv4" and "ipv6".
> > I don't think creating and managing files manually in /proc/sys/net is
> > going to fly. It also doesn't seem very wise from a consistency and
> > complexity pov. I'm also not sure if this would work at all wrt to file
> > creation and reference counting if there are two different ways of
> > managing them in the same subfolder...
> > (clusterip creates files manually underneath /proc/net which probably is
> > the reason why it gets away with it.)
> 
> br_netfilter is now a module, and br_netfilter_hooks.c is part of it
> IIRC, this file registers these sysctl entries from the module __init
> path.
> 
> It would be a matter of adding a new .init callback to the existing
> brnf_net_ops object in br_netfilter_hooks.c. Then, call
> register_net_sysctl() from this .init callback to register the sysctl
> entries per netns.

Actually, this is what you patch is doing...

> There is already a brnf_net area that you can reuse for this purpose,
> to place these pernetns flags...
> 
> struct brnf_net {
>         bool enabled;
> };
> 
> which is going to be glad to have more fields (under the #ifdef
> CONFIG_SYSCTL) there.

... except that struct brnf_net is not used to store the ctl_table.

So what I'm propose should be result in a small update to your patch 2/2.
