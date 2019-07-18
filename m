Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC2A6D3E0
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jul 2019 20:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfGRS1R (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Jul 2019 14:27:17 -0400
Received: from mail.us.es ([193.147.175.20]:38756 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfGRS1R (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:27:17 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 26678B5AA2
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Jul 2019 20:27:15 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 16C94DA708
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Jul 2019 20:27:15 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0C5A4DA704; Thu, 18 Jul 2019 20:27:15 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 18DDFDA708;
        Thu, 18 Jul 2019 20:27:13 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 18 Jul 2019 20:27:13 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id EE0AA4265A31;
        Thu, 18 Jul 2019 20:27:12 +0200 (CEST)
Date:   Thu, 18 Jul 2019 20:27:12 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf v3] netfilter: synproxy: fix rst sequence number
 mismatch
Message-ID: <20190718182712.xvgtkpwx3j5dxdcr@salvia>
References: <20190715193148.3334-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715193148.3334-1-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 15, 2019 at 09:31:49PM +0200, Fernando Fernandez Mancera wrote:
> 14:51:00.024418 IP 192.168.122.1.41462 > netfilter.90: Flags [S], seq
> 4023580551,
> 14:51:00.024454 IP netfilter.90 > 192.168.122.1.41462: Flags [S.], seq
> 727560212, ack 4023580552,
> 14:51:00.024524 IP 192.168.122.1.41462 > netfilter.90: Flags [.], ack 1,
> 
> Note: here, synproxy will send a SYN to the real server, as the 3whs was
> completed sucessfully. Instead of a syn/ack that we can intercept, we instead
> received a reset packet from the real backend, that we forward to the original
> client. However, we don't use the correct sequence number, so the reset is not
> effective in closing the connection coming from the client.
> 
> 14:51:00.024550 IP netfilter.90 > 192.168.122.1.41462: Flags [R.], seq
> 3567407084,
> 14:51:00.231196 IP 192.168.122.1.41462 > netfilter.90: Flags [.], ack 1,
> 14:51:00.647911 IP 192.168.122.1.41462 > netfilter.90: Flags [.], ack 1,
> 14:51:01.474395 IP 192.168.122.1.41462 > netfilter.90: Flags [.], ack 1,

Applied, thanks Fernando.
