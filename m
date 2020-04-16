Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5991ACF4F
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Apr 2020 20:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgDPSEn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Apr 2020 14:04:43 -0400
Received: from correo.us.es ([193.147.175.20]:35456 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgDPSEm (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:04:42 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AB4F911EB97
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Apr 2020 20:04:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9D91B12396A
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Apr 2020 20:04:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 92FEC12395E; Thu, 16 Apr 2020 20:04:39 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6790A12395E;
        Thu, 16 Apr 2020 20:04:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 16 Apr 2020 20:04:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4002742EF4E0;
        Thu, 16 Apr 2020 20:04:37 +0200 (CEST)
Date:   Thu, 16 Apr 2020 20:04:36 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Manoj Basapathi <manojbm@codeaurora.org>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        sharathv@qti.qualcomm.com, ssaha@qti.qualcomm.com,
        vidulak@qti.qualcomm.com, manojbm@qti.qualcomm.com,
        subashab@codeaurora.org, Sauvik Saha <ssaha@codeaurora.org>
Subject: Re: [PATCH] [nf,v3] idletimer extension :  Add alarm timer option
Message-ID: <20200416180436.22actuvkt4l6zwpl@salvia>
References: <20200416045329.9573-1-manojbm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416045329.9573-1-manojbm@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 16, 2020 at 10:23:29AM +0530, Manoj Basapathi wrote:
> Introduce "--alarm" option for idletimer rule.
> If it is present, hardidle-timer is used, else default timer.
> The default idletimer starts a deferrable timer or in other
> words the timer will cease to run when cpu is in suspended
> state. This change introduces the option to start a
> non-deferrable or alarm timer which will continue to run even
> when the cpu is in suspended state.

Applied, thanks.
