Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6010546526
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jun 2022 13:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347525AbiFJLKE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Jun 2022 07:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349267AbiFJLJ6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:09:58 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B5146407
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Jun 2022 04:09:49 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nzcWR-0006ii-9p; Fri, 10 Jun 2022 13:09:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH nft] Revert "scanner: flags: move to own scope"
Date:   Fri, 10 Jun 2022 13:09:38 +0200
Message-Id: <20220610110938.12845-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Excess nesting of scanner scopes is very fragile and error prone:

rule `iif != lo ip daddr 127.0.0.1/8 counter limit rate 1/second log flags all prefix "nft_lo4 " drop`
fails with `Error: No symbol type information` hinting at `prefix`

Problem is that we nest via:
 counter
   limit
     log
    flags

By the time 'prefix' is scanned, state is still stuck in 'counter' due
to this nesting.  Working around "prefix" isn't enough, any other
keyword, e.g. "level" in 'flags all level debug' will be parsed as 'string' too.

So, revert this.

Fixes: a16697097e2b ("scanner: flags: move to own scope")
Reported-by: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/parser.h                  |  1 -
 src/parser_bison.y                | 29 ++++++++++++++---------------
 src/scanner.l                     | 18 +++++++-----------
 tests/shell/testcases/parsing/log | 10 ++++++++++
 4 files changed, 31 insertions(+), 27 deletions(-)
 create mode 100755 tests/shell/testcases/parsing/log

diff --git a/include/parser.h b/include/parser.h
index f32154cca44d..d8d2eb115922 100644
--- a/include/parser.h
+++ b/include/parser.h
@@ -35,7 +35,6 @@ enum startcond_type {
 	PARSER_SC_CT,
 	PARSER_SC_COUNTER,
 	PARSER_SC_ETH,
-	PARSER_SC_FLAGS,
 	PARSER_SC_ICMP,
 	PARSER_SC_IGMP,
 	PARSER_SC_IP,
diff --git a/src/parser_bison.y b/src/parser_bison.y
index ca5c488cd5ff..2a0240fb9862 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -942,7 +942,6 @@ close_scope_esp		: { scanner_pop_start_cond(nft->scanner, PARSER_SC_EXPR_ESP); }
 close_scope_eth		: { scanner_pop_start_cond(nft->scanner, PARSER_SC_ETH); };
 close_scope_export	: { scanner_pop_start_cond(nft->scanner, PARSER_SC_CMD_EXPORT); };
 close_scope_fib		: { scanner_pop_start_cond(nft->scanner, PARSER_SC_EXPR_FIB); };
-close_scope_flags	: { scanner_pop_start_cond(nft->scanner, PARSER_SC_FLAGS); };
 close_scope_frag	: { scanner_pop_start_cond(nft->scanner, PARSER_SC_EXPR_FRAG); };
 close_scope_fwd		: { scanner_pop_start_cond(nft->scanner, PARSER_SC_STMT_FWD); };
 close_scope_hash	: { scanner_pop_start_cond(nft->scanner, PARSER_SC_EXPR_HASH); };
@@ -1679,7 +1678,7 @@ table_block_alloc	:	/* empty */
 			}
 			;
 
-table_options		:	FLAGS		STRING	close_scope_flags
+table_options		:	FLAGS		STRING
 			{
 				if (strcmp($2, "dormant") == 0) {
 					$<table>0->flags |= TABLE_F_DORMANT;
@@ -1946,7 +1945,7 @@ set_block		:	/* empty */	{ $$ = $<set>-1; }
 				datatype_set($1->key, $3->dtype);
 				$$ = $1;
 			}
-			|	set_block	FLAGS		set_flag_list	stmt_separator	close_scope_flags
+			|	set_block	FLAGS		set_flag_list	stmt_separator
 			{
 				$1->flags = $3;
 				$$ = $1;
@@ -2080,7 +2079,7 @@ map_block		:	/* empty */	{ $$ = $<set>-1; }
 				$1->flags  |= NFT_SET_OBJECT;
 				$$ = $1;
 			}
-			|	map_block	FLAGS		set_flag_list	stmt_separator	close_scope_flags
+			|	map_block	FLAGS		set_flag_list	stmt_separator
 			{
 				$1->flags |= $3;
 				$$ = $1;
@@ -2153,7 +2152,7 @@ flowtable_block		:	/* empty */	{ $$ = $<flowtable>-1; }
 			{
 				$$->flags |= NFT_FLOWTABLE_COUNTER;
 			}
-			|	flowtable_block	FLAGS	OFFLOAD	stmt_separator	close_scope_flags
+			|	flowtable_block	FLAGS	OFFLOAD	stmt_separator
 			{
 				$$->flags |= FLOWTABLE_F_HW_OFFLOAD;
 			}
@@ -2520,7 +2519,7 @@ dev_spec		:	DEVICE	string
 			|	/* empty */		{ $$ = NULL; }
 			;
 
-flags_spec		:	FLAGS		OFFLOAD	close_scope_flags
+flags_spec		:	FLAGS		OFFLOAD
 			{
 				$<chain>0->flags |= CHAIN_F_HW_OFFLOAD;
 			}
@@ -3126,7 +3125,7 @@ log_arg			:	PREFIX			string
 				$<stmt>0->log.level	= $2;
 				$<stmt>0->log.flags 	|= STMT_LOG_LEVEL;
 			}
-			|	FLAGS			log_flags	close_scope_flags
+			|	FLAGS			log_flags
 			{
 				$<stmt>0->log.logflags	|= $2;
 			}
@@ -3828,13 +3827,13 @@ queue_stmt		:	queue_stmt_compat	close_scope_queue
 			{
 				$$ = queue_stmt_alloc(&@$, $3, 0);
 			}
-			|	QUEUE FLAGS	queue_stmt_flags close_scope_flags TO queue_stmt_expr close_scope_queue
+			|	QUEUE FLAGS	queue_stmt_flags TO queue_stmt_expr close_scope_queue
 			{
-				$$ = queue_stmt_alloc(&@$, $6, $3);
+				$$ = queue_stmt_alloc(&@$, $5, $3);
 			}
-			|	QUEUE	FLAGS	queue_stmt_flags close_scope_flags QUEUENUM queue_stmt_expr_simple close_scope_queue
+			|	QUEUE	FLAGS	queue_stmt_flags QUEUENUM queue_stmt_expr_simple close_scope_queue
 			{
-				$$ = queue_stmt_alloc(&@$, $6, $3);
+				$$ = queue_stmt_alloc(&@$, $5, $3);
 			}
 			;
 
@@ -5501,7 +5500,7 @@ comp_hdr_expr		:	COMP	comp_hdr_field	close_scope_comp
 			;
 
 comp_hdr_field		:	NEXTHDR		{ $$ = COMPHDR_NEXTHDR; }
-			|	FLAGS	close_scope_flags	{ $$ = COMPHDR_FLAGS; }
+			|	FLAGS		{ $$ = COMPHDR_FLAGS; }
 			|	CPI		{ $$ = COMPHDR_CPI; }
 			;
 
@@ -5562,7 +5561,7 @@ tcp_hdr_field		:	SPORT		{ $$ = TCPHDR_SPORT; }
 			|	ACKSEQ		{ $$ = TCPHDR_ACKSEQ; }
 			|	DOFF		{ $$ = TCPHDR_DOFF; }
 			|	RESERVED	{ $$ = TCPHDR_RESERVED; }
-			|	FLAGS	close_scope_flags	{ $$ = TCPHDR_FLAGS; }
+			|	FLAGS		{ $$ = TCPHDR_FLAGS; }
 			|	WINDOW		{ $$ = TCPHDR_WINDOW; }
 			|	CHECKSUM	{ $$ = TCPHDR_CHECKSUM; }
 			|	URGPTR		{ $$ = TCPHDR_URGPTR; }
@@ -5676,7 +5675,7 @@ sctp_chunk_type		:	DATA		{ $$ = SCTP_CHUNK_TYPE_DATA; }
 			;
 
 sctp_chunk_common_field	:	TYPE	close_scope_type	{ $$ = SCTP_CHUNK_COMMON_TYPE; }
-			|	FLAGS	close_scope_flags	{ $$ = SCTP_CHUNK_COMMON_FLAGS; }
+			|	FLAGS	{ $$ = SCTP_CHUNK_COMMON_FLAGS; }
 			|	LENGTH	{ $$ = SCTP_CHUNK_COMMON_LENGTH; }
 			;
 
@@ -5844,7 +5843,7 @@ rt4_hdr_expr		:	RT4	rt4_hdr_field	close_scope_rt
 			;
 
 rt4_hdr_field		:	LAST_ENT	{ $$ = RT4HDR_LASTENT; }
-			|	FLAGS	close_scope_flags	{ $$ = RT4HDR_FLAGS; }
+			|	FLAGS		{ $$ = RT4HDR_FLAGS; }
 			|	TAG		{ $$ = RT4HDR_TAG; }
 			|	SID		'['	NUM	']'
 			{
diff --git a/src/scanner.l b/src/scanner.l
index 2154281e7657..7eb74020ef84 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -201,7 +201,6 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 %s SCANSTATE_CT
 %s SCANSTATE_COUNTER
 %s SCANSTATE_ETH
-%s SCANSTATE_FLAGS
 %s SCANSTATE_ICMP
 %s SCANSTATE_IGMP
 %s SCANSTATE_IP
@@ -339,7 +338,7 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 "jump"			{ return JUMP; }
 "goto"			{ return GOTO; }
 "return"		{ return RETURN; }
-<SCANSTATE_EXPR_QUEUE,SCANSTATE_STMT_DUP,SCANSTATE_STMT_FWD,SCANSTATE_STMT_NAT,SCANSTATE_STMT_TPROXY,SCANSTATE_FLAGS,SCANSTATE_IP,SCANSTATE_IP6>"to"			{ return TO; } /* XXX: SCANSTATE_FLAGS and SCANSTATE_IP here are workarounds */
+<SCANSTATE_EXPR_QUEUE,SCANSTATE_STMT_DUP,SCANSTATE_STMT_FWD,SCANSTATE_STMT_NAT,SCANSTATE_STMT_TPROXY,SCANSTATE_IP,SCANSTATE_IP6>"to"			{ return TO; } /* XXX: SCANSTATE_IP is a workaround */
 
 "inet"			{ return INET; }
 "netdev"		{ return NETDEV; }
@@ -363,14 +362,9 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 "index"			{ return INDEX; }
 "comment"		{ return COMMENT; }
 
-<SCANSTATE_FLAGS>{
-	"constant"		{ return CONSTANT; }
-	"dynamic"		{ return DYNAMIC; }
-
-	/* log flags */
-	"all"			{ return ALL; }
-}
+"constant"		{ return CONSTANT; }
 "interval"		{ return INTERVAL; }
+"dynamic"		{ return DYNAMIC; }
 "auto-merge"		{ return AUTOMERGE; }
 "timeout"		{ return TIMEOUT; }
 "gc-interval"		{ return GC_INTERVAL; }
@@ -418,7 +412,7 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 }
 
 "queue"			{ scanner_push_start_cond(yyscanner, SCANSTATE_EXPR_QUEUE); return QUEUE;}
-<SCANSTATE_FLAGS,SCANSTATE_EXPR_QUEUE>{
+<SCANSTATE_EXPR_QUEUE>{
 	"num"		{ return QUEUENUM;}
 	"bypass"	{ return BYPASS;}
 	"fanout"	{ return FANOUT;}
@@ -612,7 +606,7 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 <SCANSTATE_EXPR_COMP>{
 	"cpi"			{ return CPI; }
 }
-"flags"			{ scanner_push_start_cond(yyscanner, SCANSTATE_FLAGS); return FLAGS; }
+"flags"			{ return FLAGS; }
 
 "udp"			{ scanner_push_start_cond(yyscanner, SCANSTATE_EXPR_UDP); return UDP; }
 "udplite"		{ scanner_push_start_cond(yyscanner, SCANSTATE_EXPR_UDPLITE); return UDPLITE; }
@@ -781,6 +775,8 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 
 "notrack"		{ return NOTRACK; }
 
+"all"			{ return ALL; }
+
 <SCANSTATE_CMD_EXPORT,SCANSTATE_CMD_IMPORT,SCANSTATE_CMD_MONITOR>{
 	"xml"			{ return XML; }
 	"json"			{ return JSON; }
diff --git a/tests/shell/testcases/parsing/log b/tests/shell/testcases/parsing/log
new file mode 100755
index 000000000000..0b89d589c4c1
--- /dev/null
+++ b/tests/shell/testcases/parsing/log
@@ -0,0 +1,10 @@
+#!/bin/bash
+
+$NFT add table t || exit 1
+$NFT add chain t c || exit 1
+$NFT add rule t c 'iif != lo ip daddr 127.0.0.1/8 counter limit rate 1/second log flags all prefix "nft_lo4 " drop' || exit 1
+$NFT add rule t c 'iif != lo ip daddr 127.0.0.1/8 counter limit rate 1/second log flags all level debug drop' || exit 1
+$NFT delete table t || exit 1
+
+exit 0
+
-- 
2.35.1

