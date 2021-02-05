Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5EA310B17
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Feb 2021 13:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhBEMbi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 Feb 2021 07:31:38 -0500
Received: from correo.us.es ([193.147.175.20]:42810 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhBEM30 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:29:26 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 75FF0ADCEF
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Feb 2021 13:28:27 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 62DB3DA722
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Feb 2021 13:28:27 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 57DADDA78C; Fri,  5 Feb 2021 13:28:27 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-106.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,USER_IN_WELCOMELIST,
        USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1A9EBDA722;
        Fri,  5 Feb 2021 13:28:25 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 05 Feb 2021 13:28:25 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id F2CC542DF560;
        Fri,  5 Feb 2021 13:28:24 +0100 (CET)
Date:   Fri, 5 Feb 2021 13:28:24 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [RFC conntrack-tools PATCH] conntrack-tools: introduce
 conntrackdctl
Message-ID: <20210205122824.GA16269@salvia>
References: <161243463641.9380.7754148010781645692.stgit@endurance>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <161243463641.9380.7754148010781645692.stgit@endurance>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:32:06AM +0100, Arturo Borrero Gonzalez wrote:
> Separate conntrackd command line client functionalities into a different
> binary.
> 
> This should help with several things:
>  * avoid reading and parsing the config file, which can fail in some enviroments, for example if
>    conntrackd is running inside a netns and the referenced interfaces/addresses doesn't exist in
>    the namespace conntrackd client command is running from.
>  * easily update conntrakdctl with more functionalities without polluting the daemon binary
>  * easier code maintenance
[...]
> @@ -333,15 +151,6 @@ int main(int argc, char *argv[])
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	if (type == REQUEST) {
> -		if (do_local_request(action, &conf.local, local_step) == -1) {
> -			dlog(LOG_ERR, "can't connect: is conntrackd "
> -			     "running? appropriate permissions?");
> -			exit(EXIT_FAILURE);
> -		}
> -		exit(EXIT_SUCCESS);
> -	}

The existing interface needs to be in place to be backward compatible.

I'm fine for you to add this, but we'll have to leave the existing
interface for quite a bit of time, it might take years before we can
deprecate the old way.
