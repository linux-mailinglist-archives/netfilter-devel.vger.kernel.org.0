Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9995FF895
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Apr 2019 14:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfD3MPC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Apr 2019 08:15:02 -0400
Received: from mail.us.es ([193.147.175.20]:40624 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfD3MPC (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:15:02 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B733511FBE3
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Apr 2019 14:15:00 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A74A9DA702
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Apr 2019 14:15:00 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9CB96DA707; Tue, 30 Apr 2019 14:15:00 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A1420DA702;
        Tue, 30 Apr 2019 14:14:58 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 30 Apr 2019 14:14:58 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (129.166.216.87.static.jazztel.es [87.216.166.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 694964265A31;
        Tue, 30 Apr 2019 14:14:58 +0200 (CEST)
Date:   Tue, 30 Apr 2019 14:14:57 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     a@juaristi.eus
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH ulogd2,v2 2/2] IPFIX: Introduce template record support
Message-ID: <20190430121457.6ldk4t7nr4nf6vjl@salvia>
References: <20190426075807.7528-1-a@juaristi.eus>
 <20190426075807.7528-2-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426075807.7528-2-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:58:07AM +0200, a@juaristi.eus wrote:
> From: Ander Juaristi <a@juaristi.eus>
> 
> This commit adds the ability to send template records
> to the remote collector.
> 
> In addition, it also introduces a new
> configuration parameter 'send_template', which tells when template
> records should be sent. It accepts the following string values:
> 
>  - "once": Send the template record only the first time (might be coalesced
>     with data records).
>  - "always": Send the template record always, with every data record that is sent
>     to the collector (multiple data records might be sent together).
>  - "never": Assume the collector knows the schema already. Do not send template records.
> 
> If omitted, the default value for 'send_template' is "once".

Applied, thanks.
