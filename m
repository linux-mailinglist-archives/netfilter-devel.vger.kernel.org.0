Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07FE2D29FA
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Dec 2020 12:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgLHLvF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Dec 2020 06:51:05 -0500
Received: from correo.us.es ([193.147.175.20]:43678 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgLHLvF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:51:05 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1283A1F0CE9
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Dec 2020 12:50:15 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0469AFB46A
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Dec 2020 12:50:15 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EE32CDA72F; Tue,  8 Dec 2020 12:50:14 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CCE03DA73F;
        Tue,  8 Dec 2020 12:50:12 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 08 Dec 2020 12:50:12 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AD19E4265A5A;
        Tue,  8 Dec 2020 12:50:12 +0100 (CET)
Date:   Tue, 8 Dec 2020 12:50:20 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [conntrack-tools PATCH v2 2/2] conntrackd: external_inject:
 report inject issues as warning
Message-ID: <20201208115020.GB26272@salvia>
References: <160707894303.12188.18393188272117372516.stgit@endurance>
 <160707895903.12188.7283813676910230247.stgit@endurance>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160707895903.12188.7283813676910230247.stgit@endurance>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:50:25AM +0100, Arturo Borrero Gonzalez wrote:
> In busy firewalls that run conntrackd in NOTRACK with both internal and external caches disabled,
> external_inject can get lots of traffic. In case of issues injecting or updating conntrack entries
> a log entry will be generated, the infamous inject-addX, inject-updX messages.
> 
> But there is nothing end users can do about this error message, which is purely internal. This
> patch is basically cosmetic, relaxing the message from ERROR to WARNING. The information reported
> is also extended a bit. The idea is to leave ERROR messages to issues that would *stop* or
> *prevent* conntrackd from working at all.
> 
> Another nice thing to do in the future is to rate-limit this message, which is generated in the
> data path and can easily fill log files. But ideally, the actual root cause would be fixed, and
> there would be no WARNING message reported at all, meaning that all conntrack entries are smoothly
> synced between the firewalls in the cluster. We can work on that later.

Also applied.
