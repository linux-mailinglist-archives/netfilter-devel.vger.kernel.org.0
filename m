Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E067F14A
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Aug 2019 11:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfHBJho (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Aug 2019 05:37:44 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:60334 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391660AbfHBJfh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:35:37 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1htTyJ-0001so-RX; Fri, 02 Aug 2019 11:35:35 +0200
Date:   Fri, 2 Aug 2019 11:35:35 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] expr: allow export of notrack expr
Message-ID: <20190802093535.ujni4pckhrihjtaj@breakpoint.cc>
References: <CABWYdi0aifR5EDAMVJ2vh6nURXwc0ED75hOkkWvU6-8icmvM_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi0aifR5EDAMVJ2vh6nURXwc0ED75hOkkWvU6-8icmvM_A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ivan Babrou <ivan@cloudflare.com> wrote:
> Currently it's impossible to export notrack expr as json,
> as it lacks snprintf member and triggers segmentation fault.

Hmm, works for me:

table ip raw {
        chain prerouting {
                type filter hook prerouting priority -300; policy accept;
                udp dport 53 notrack
}

gets exported as:

nft -j list ruleset
{"nftables": [{"metainfo": {"version": "0.9.1", "release_name": "Headless Horseman", "json_schema_version": 1}}, {"table": {"family": "ip", "name": "raw", "handle": 1}}, {"chain": {"family": "ip", "table": "raw", "name": "prerouting", "handle": 1, "type": "filter", "hook": "prerouting", "prio": -300, "policy": "accept"}}, {"rule": {"family": "ip", "table": "raw", "chain": "prerouting", "handle": 3, "expr": [{"match": {"op": "==", "left": {"payload": {"protocol": "udp", "field": "dport"}}, "right": 53}}, {"notrack": null}]}}]}
