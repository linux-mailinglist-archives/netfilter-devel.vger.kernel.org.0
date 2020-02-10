Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432B41572BD
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Feb 2020 11:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgBJKRi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Feb 2020 05:17:38 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:28415 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgBJKRi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:17:38 -0500
Date:   Mon, 10 Feb 2020 10:17:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1581329856;
        bh=Td0Vl15zPzDCFBlVnqfEzoPUmWnwrS3Z4XWtyJGTBSE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=QETNyJW8pQncPHVWWkI4Bzpo3K4Dmj9QCeU5X8J4pPCupxND3HZUZNFo2y02QgIVY
         0Tv0uOYLXvMISCrsSVqCj+hs9kxcZEpdwzyTYLUNXVPI0+E6SdSgLHCl+4I71hXlKg
         unUV9pf0eG+JYDhT1SknH2SbFx1UlQaRuPVUkchk=
To:     netfilter-devel@vger.kernel.org
From:   Laurent Fasnacht <fasnacht@protonmail.ch>
Cc:     Laurent Fasnacht <fasnacht@protonmail.ch>
Reply-To: Laurent Fasnacht <fasnacht@protonmail.ch>
Subject: [PATCH nft include v2 7/7] scanner: remove parser_state->indesc_idx
Message-ID: <20200210101709.9182-8-fasnacht@protonmail.ch>
In-Reply-To: <20200210101709.9182-1-fasnacht@protonmail.ch>
References: <20200210101709.9182-1-fasnacht@protonmail.ch>
Feedback-ID: 67Kw-YMwrBchoIMLcnFuA64ZnJub6AgnNvfJUjsgbTTSp4dmymKgGy_PLLqmOsJ9F58iClONCeGYaqp9YPx84w==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        T_FILL_THIS_FORM_SHORT shortcircuit=no autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Now that we have a proper stack implementation, we don't need an
additional counter for the number of buffer state pushed.

Signed-off-by: Laurent Fasnacht <fasnacht@protonmail.ch>
---
 include/parser.h | 1 -
 src/scanner.l    | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/parser.h b/include/parser.h
index 66db92d8..636d1c88 100644
--- a/include/parser.h
+++ b/include/parser.h
@@ -15,7 +15,6 @@
=20
 struct parser_state {
 =09struct input_descriptor=09=09*indesc;
-=09unsigned int=09=09=09indesc_idx;
 =09struct list_head=09=09indesc_list;
=20
 =09struct list_head=09=09*msgs;
diff --git a/src/scanner.l b/src/scanner.l
index 8407a2a1..39e7ae0f 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -674,12 +674,10 @@ static void scanner_push_indesc(struct parser_state *=
state,
 =09=09list_add(&indesc->list, &state->indesc->list);
 =09}
 =09state->indesc =3D indesc;
-=09state->indesc_idx++;
 }
=20
 static void scanner_pop_indesc(struct parser_state *state)
 {
-=09state->indesc_idx--;
 =09if (!list_empty(&state->indesc_list)) {
 =09=09state->indesc =3D list_entry(state->indesc->list.prev, struct input_=
descriptor, list);
 =09} else {
@@ -968,10 +966,6 @@ void scanner_destroy(struct nft_ctx *nft)
 {
 =09struct parser_state *state =3D yyget_extra(nft->scanner);
=20
-=09do {
-=09=09yypop_buffer_state(nft->scanner);
-=09} while (state->indesc_idx--);
-
 =09input_descriptor_list_destroy(state);
 =09yylex_destroy(nft->scanner);
 }
--=20
2.20.1


