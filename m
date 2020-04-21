Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078B71B253A
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2020 13:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgDULi1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Apr 2020 07:38:27 -0400
Received: from correo.us.es ([193.147.175.20]:47596 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgDULi1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:38:27 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2E4FFB4977
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Apr 2020 13:38:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1EEEBFC54C
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Apr 2020 13:38:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1DC4BFA525; Tue, 21 Apr 2020 13:38:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C34FCFF6EF;
        Tue, 21 Apr 2020 13:38:23 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 21 Apr 2020 13:38:23 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A160542EF42A;
        Tue, 21 Apr 2020 13:38:23 +0200 (CEST)
Date:   Tue, 21 Apr 2020 13:38:23 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: libmnl & rtnetlink questions
Message-ID: <20200421113823.2bfig5hbx47ld2n2@salvia>
References: <223164bb-40f0-d1c7-3793-c56c85127f3c@gmail.com>
 <20200421113005.s5xrdtvu35hdoz2t@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421113005.s5xrdtvu35hdoz2t@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Apr 21, 2020 at 01:30:05PM +0200, Pablo Neira Ayuso wrote:
> On Mon, Apr 13, 2020 at 02:00:22PM -0500, Ian Pilcher wrote:
> > First off, please let me know if this list isn't an appropriate place
> > for these sorts of questions.
> > 
> > With that out of the way, I'm trying to understand the sample program
> > at:
> > 
> >   http://git.netfilter.org/libmnl/tree/examples/rtnl/rtnl-link-dump.c
> > 
> > I've been able to puzzle most of it out, but I'm confused by the
> > use of the struct rtgenmsg (declared on line 88 and used on lines
> > 95-96).
> > 
> > * Based on rtnetlink(7), shouldn't this more properly be a struct
> >   ifinfomsg (even though only rtgen_family/ifi_family is set)?
> 
> RTM_GETLINK expects ifinfomsg, yes.

commit 905cf0abe8c2c892313f08e38d808eee4e794987
Author: David Ahern <dsahern@gmail.com>
Date:   Sun Oct 7 20:16:30 2018 -0700

    rtnetlink: Update rtnl_dump_ifinfo for strict data checking
    
    Update rtnl_dump_ifinfo for strict data checking. If the flag is set,
    the dump request is expected to have an ifinfomsg struct as the header
    potentially followed by one or more attributes. Any data passed in the
    header or as an attribute is taken as a request to influence the data
    returned. Only values supported by the dump handler are allowed to be
    non-0 or set in the request. At the moment only the IFA_TARGET_NETNSID,
    IFLA_EXT_MASK, IFLA_MASTER, and IFLA_LINKINFO attributes are supported.

Probably this explains the reason why.

> > * More importantly, why is setting this to AF_PACKET required at all?
> >   Testing the program without setting it reveals that it definitely is
> >   required, but I haven't been able to find anything that explains *why*
> >   that is the case.
> 
> Probably AF_UNSPEC is more appropriate there?

Would you send a patch for this?

Thanks.
