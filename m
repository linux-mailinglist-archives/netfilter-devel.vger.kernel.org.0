Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD1B1419A0
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Jan 2020 21:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgARUjF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Jan 2020 15:39:05 -0500
Received: from correo.us.es ([193.147.175.20]:54650 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgARUjF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:39:05 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 8C14A39626C
        for <netfilter-devel@vger.kernel.org>; Sat, 18 Jan 2020 21:39:03 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7E5E8DA716
        for <netfilter-devel@vger.kernel.org>; Sat, 18 Jan 2020 21:39:03 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 733E0DA710; Sat, 18 Jan 2020 21:39:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 73ADDDA711;
        Sat, 18 Jan 2020 21:39:01 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 18 Jan 2020 21:39:01 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5541441E4800;
        Sat, 18 Jan 2020 21:39:01 +0100 (CET)
Date:   Sat, 18 Jan 2020 21:39:00 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jiri Wiesner <jwiesner@suse.com>
Cc:     netfilter-devel@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH nf] netfilter: conntrack: sctp: use distinct states for
 new SCTP connections
Message-ID: <20200118203900.4cbujiax7jcg73dk@salvia>
References: <20200118121050.GA22909@incl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118121050.GA22909@incl>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jan 18, 2020 at 01:10:50PM +0100, Jiri Wiesner wrote:
> The netlink notifications triggered by the INIT and INIT_ACK chunks
> for a tracked SCTP association do not include protocol information
> for the corresponding connection - SCTP state and verification tags
> for the original and reply direction are missing. Since the connection
> tracking implementation allows user space programs to receive
> notifications about a connection and then create a new connection
> based on the values received in a notification, it makes sense that
> INIT and INIT_ACK notifications should contain the SCTP state
> and verification tags available at the time when a notification
> is sent. The missing verification tags cause a newly created
> netfilter connection to fail to verify the tags of SCTP packets
> when this connection has been created from the values previously
> received in an INIT or INIT_ACK notification.
> 
> A PROTOINFO event is cached in sctp_packet() when the state
> of a connection changes. The CLOSED and COOKIE_WAIT state will
> be used for connections that have seen an INIT and INIT_ACK chunk,
> respectively. The distinct states will cause a connection state
> change in sctp_packet().

This problem shows through conntrack -E, correct?

Thanks.
