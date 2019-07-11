Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AD365663
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jul 2019 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfGKMIJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Jul 2019 08:08:09 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:54978 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728530AbfGKMIJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Jul 2019 08:08:09 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hlXrk-0005nW-8M; Thu, 11 Jul 2019 14:08:00 +0200
Date:   Thu, 11 Jul 2019 14:08:00 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Jakub Jankowski <shasta@toxcorp.com>
Cc:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        netfilter@vger.kernel.org, mhemsley@open-systems.com,
        netfilter-devel@vger.kernel.org
Subject: Re: 3-way handshake sets conntrack timeout to max_retrans
Message-ID: <20190711120800.nxmib65hl5blorxy@breakpoint.cc>
References: <alpine.LNX.2.21.1907100147540.26040@kich.toxcorp.com>
 <alpine.DEB.2.20.1907101242560.17522@blackhole.kfki.hu>
 <alpine.LNX.2.21.1907101251090.26040@kich.toxcorp.com>
 <alpine.DEB.2.20.1907111056480.22623@blackhole.kfki.hu>
 <alpine.LNX.2.21.1907111126240.26040@kich.toxcorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1907111126240.26040@kich.toxcorp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jakub Jankowski <shasta@toxcorp.com> wrote:

Thanks for the detailed bug report!

Can you try this fix?

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -472,6 +472,7 @@ static bool tcp_in_window(const struct nf_conn *ct,
 	struct ip_ct_tcp_state *receiver = &state->seen[!dir];
 	const struct nf_conntrack_tuple *tuple = &ct->tuplehash[dir].tuple;
 	__u32 seq, ack, sack, end, win, swin;
+	u16 win_raw;
 	s32 receiver_offset;
 	bool res, in_recv_win;
 
@@ -480,7 +481,8 @@ static bool tcp_in_window(const struct nf_conn *ct,
 	 */
 	seq = ntohl(tcph->seq);
 	ack = sack = ntohl(tcph->ack_seq);
-	win = ntohs(tcph->window);
+	win_raw = ntohs(tcph->window);
+	win = win_raw;
 	end = segment_seq_plus_len(seq, skb->len, dataoff, tcph);
 
 	if (receiver->flags & IP_CT_TCP_FLAG_SACK_PERM)
@@ -655,14 +657,14 @@ static bool tcp_in_window(const struct nf_conn *ct,
 			    && state->last_seq == seq
 			    && state->last_ack == ack
 			    && state->last_end == end
-			    && state->last_win == win)
+			    && state->last_win == win_raw)
 				state->retrans++;
 			else {
 				state->last_dir = dir;
 				state->last_seq = seq;
 				state->last_ack = ack;
 				state->last_end = end;
-				state->last_win = win;
+				state->last_win = win_raw;
 				state->retrans = 0;
 			}
 		}
