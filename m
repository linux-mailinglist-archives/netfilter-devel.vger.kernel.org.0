Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C481B203D4B
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2020 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgFVQ7f (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jun 2020 12:59:35 -0400
Received: from mail.thelounge.net ([91.118.73.15]:60745 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbgFVQ7f (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:59:35 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 49rFxw1WKxzXNv;
        Mon, 22 Jun 2020 18:59:32 +0200 (CEST)
Subject: Re: iptables user space performance benchmarks published
To:     Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200619141157.GU23632@orbyte.nwl.cc>
 <20200622124207.GA25671@salvia>
 <faf06553-c894-e34c-264e-c0265e3ee071@thelounge.net>
 <20200622140450.GZ23632@orbyte.nwl.cc>
 <1a32ffd2-b3a2-cf60-9928-3baa58f7d9ef@thelounge.net>
 <20200622145410.GB23632@orbyte.nwl.cc>
 <eef37fef-0e6c-b948-7195-76ce2e2be93b@thelounge.net>
 <20200622154412.GC23632@orbyte.nwl.cc>
 <80246bf7-7496-0bfc-d5d7-329ae0fb3b1f@thelounge.net>
 <20200622164544.GD23632@orbyte.nwl.cc>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <7ed4762d-3fc6-341b-c4f7-27aa22f1486e@thelounge.net>
Date:   Mon, 22 Jun 2020 18:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622164544.GD23632@orbyte.nwl.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil

Am 22.06.20 um 18:45 schrieb Phil Sutter:
>> but what is the replacement for iterate "/proc/net/ip_tables_names" and
>> "/proc/net/ip6_tables_names" in case "iptables-nft" is in use
>>
>> that is not only used for reset but also on several places for status
>> counters, display rulets in "-t filter", "-t mangle and "-t raw"
>>
>> -------------------------------
>>
>> missing that explains that everything is falling in pieces and add
>> things which are supposed to be no longer there fails
> 
> Ah yes, that's an obvious change and there's nothing we can do about it.
> Unlike legacy iptables, there are no dedicated modules supporting each
> table in iptables-nft. For instance, nft_chain_filter.ko suffices for
> raw, filter and security tables. For nat table you need nft_chain_nat.ko
> and mangle needs nft_chain_route.ko (actually just for OUTPUT chain).
> 
>> $IPTABLES here is a macro within my application
>>
>>  for TABLE in $(<'/proc/net/ip_tables_names'); do
>>   hlp_rule_ipv4 "$IPTABLES -t $TABLE -F"
>>   hlp_rule_ipv4 "$IPTABLES -t $TABLE -X"
>>  done
>>  if [ "$IPV6_LOADED" == 1 ]; then
>>   for TABLE in $(<'/proc/net/ip6_tables_names'); do
>>    hlp_rule_ipv6 "$IPTABLES -t $TABLE -F"
>>    hlp_rule_ipv6 "$IPTABLES -t $TABLE -X"
>>   done
>>  fi
> 
> For iptables-services in Fedora, I simply hard-coded the table names

that's exactly what i want to avoid beause in case of iptables-legacy
that would load stuff not needed

given that "iptables-nft -t raw", "iptables-nft -t mangle",
"iptables-nft -t nat" are working as expected as far as i can see some
way with "iptables-nft" would be cool

---------------------

[root@firewall:/proc/net]$ iptables-nft -t natx -L
iptables v1.8.3 (nf_tables): table 'natx' does not exist
Perhaps iptables or your kernel needs to be upgraded.

well i could write a loop testing that and provide a abstraction layer
in case the whole beast runs in iptables-nft mode but that's ugly as hell
