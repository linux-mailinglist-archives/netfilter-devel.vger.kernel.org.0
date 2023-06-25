Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0073D12E
	for <lists+netfilter-devel@lfdr.de>; Sun, 25 Jun 2023 15:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjFYNkr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Jun 2023 09:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYNkq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Jun 2023 09:40:46 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BD31B7;
        Sun, 25 Jun 2023 06:40:42 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qDPyp-0005bI-8c; Sun, 25 Jun 2023 15:40:39 +0200
Date:   Sun, 25 Jun 2023 15:40:39 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Jason Vas Dias <jason.vas.dias@ptt.ie>,
        Jason Vas Dias <jason.vas.dias@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org
Subject: Re: Linux netfilter / iptables : How to enable iptables TRACE chain
 handling with nf_log_syslog on RHEL8+?
Message-ID: <20230625134039.GB3207@breakpoint.cc>
References: <hhttuv65e9.fsf@jvdspc.jvds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hhttuv65e9.fsf@jvdspc.jvds.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jason Vas Dias <jason.vas.dias@ptt.ie> wrote:
> 
> Good day -
> 
>   On a Linux RHEL8 system, I have enabled these iptables rules,
>   which I am led to believe should enable ICMP packet syslog
>   logging on interface ingress & egress :
> 
>     # iptables -L -t raw
>     Chain PREROUTING (policy ACCEPT)
>     target     prot opt source               destination         
>     TRACE      icmp --  anywhere             anywhere            
> 
>     Chain OUTPUT (policy ACCEPT)
>     target     prot opt source               destination         
>     TRACE      icmp --  anywhere             anywhere            

Run "xtables-monitor --trace".
