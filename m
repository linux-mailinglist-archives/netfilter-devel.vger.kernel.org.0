Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845D08027F
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Aug 2019 00:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfHBWER (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Aug 2019 18:04:17 -0400
Received: from correo.us.es ([193.147.175.20]:50368 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731199AbfHBWER (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:04:17 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D0E79127C87
        for <netfilter-devel@vger.kernel.org>; Sat,  3 Aug 2019 00:04:14 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C1DFC1150CC
        for <netfilter-devel@vger.kernel.org>; Sat,  3 Aug 2019 00:04:14 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A17AD6E7A0; Sat,  3 Aug 2019 00:04:14 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F0374DA730;
        Sat,  3 Aug 2019 00:04:11 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 03 Aug 2019 00:04:11 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.211.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A58284265A2F;
        Sat,  3 Aug 2019 00:04:11 +0200 (CEST)
Date:   Sat, 3 Aug 2019 00:04:09 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     netfilter-devel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, marcelo.leitner@gmail.com,
        jiri@resnulli.us, wenxu@ucloud.cn, saeedm@mellanox.com,
        paulb@mellanox.com, gerlitz.or@gmail.com
Subject: Re: [PATCH net 0/2] flow_offload hardware priority fixes
Message-ID: <20190802220409.klwdkcvjgegz6hj2@salvia>
References: <20190801112817.24976-1-pablo@netfilter.org>
 <20190801172014.314a9d01@cakuba.netronome.com>
 <20190802110023.udfcxowe3vmihduq@salvia>
 <20190802134738.328691b4@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802134738.328691b4@cakuba.netronome.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Jakub,

On Fri, Aug 02, 2019 at 01:47:38PM -0700, Jakub Kicinski wrote:
> On Fri, 2 Aug 2019 13:00:23 +0200, Pablo Neira Ayuso wrote:
> > Hi Jakub,
> > 
> > If the user specifies 'pref' in the new rule, then tc checks if there
> > is a tcf_proto object that matches this priority. If the tcf_proto
> > object does not exist, tc creates a tcf_proto object and it adds the
> > new rule to this tcf_proto.
> > 
> > In cls_flower, each tcf_proto only stores one single rule, so if the
> > user tries to add another rule with the same 'pref', cls_flower
> > returns EEXIST.
> 
> So you're saying this doesn't work?
> 
> ip link add type dummy
> tc qdisc add dev dummy0 clsact
> tc filter add dev dummy0 ingress protocol ipv6 prio 123 flower src_ip 1111::1 action drop
> tc filter add dev dummy0 ingress protocol ipv6 prio 123 flower src_ip 1111::2 action drop

This works indeed as you describe.

I'll go back to the original netfilter basechain priority patch then:

https://patchwork.ozlabs.org/patch/1140412/

That patch removed the reference to tcf_auto_prio() already, please
let me know if you have any more specific update you would like to see
on that patch.

Thanks.
