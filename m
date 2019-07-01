Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6301B51FD8
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Jun 2019 02:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfFYATg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Jun 2019 20:19:36 -0400
Received: from mail.us.es ([193.147.175.20]:39156 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfFYATg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:19:36 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 31368C04AA
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 02:19:34 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 22195DA701
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 02:19:34 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 17CCEDA702; Tue, 25 Jun 2019 02:19:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2DF97DA701;
        Tue, 25 Jun 2019 02:19:32 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 25 Jun 2019 02:19:32 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 0CF5A4265A2F;
        Tue, 25 Jun 2019 02:19:32 +0200 (CEST)
Date:   Tue, 25 Jun 2019 02:19:31 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     =?utf-8?Q?=C4=B0brahim?= Ercan <ibrahim.metu@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH] netfilter: synproxy: erroneous TCP mss option fixed.
Message-ID: <20190625001931.lfadlvnjq5reczxh@salvia>
References: <CAK6Qs9k_bdU9ZL4WRXBGYdtfnP_qhot0hzC=uMQG6C_pkz3+2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK6Qs9k_bdU9ZL4WRXBGYdtfnP_qhot0hzC=uMQG6C_pkz3+2w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:28:07PM +0300, İbrahim Ercan wrote:
> Syn proxy isn't setting mss value correctly on client syn-ack packet.
> 
> It was sending same mss value with client send instead of the value
> user set in iptables rule.
> This patch fix that wrong behavior by passing client mss information
> to synproxy_send_client_synack correctly.

Cannot apply, wrapped by MUA, please re-submit.

Thanks.
