Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 921471572BB
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Feb 2020 11:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBJKRb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Feb 2020 05:17:31 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:24318 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgBJKRb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:17:31 -0500
Date:   Mon, 10 Feb 2020 10:17:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1581329849;
        bh=qfhK4LAW9V0baU6xmRTfewAC3vtFsivWJm6lPf19pjg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=YKIkZYbUoV0IMs+ZTh+mZqmJs/q5V11gD+fNmAssBejDAuWl+P5o8iMiLzmwedrer
         tg9vKqU5iBuKQQZ3cGfad4y44yDUg+OFzj0D7a+8w3D4n8CTvsXJEAdcg/zE2I8cCM
         QHkZNVahzdE9Rxn0LHB/jiMn63CwjyRf6pQ7Ro+8=
To:     netfilter-devel@vger.kernel.org
From:   Laurent Fasnacht <fasnacht@protonmail.ch>
Cc:     Laurent Fasnacht <fasnacht@protonmail.ch>
Reply-To: Laurent Fasnacht <fasnacht@protonmail.ch>
Subject: [PATCH nft include v2 6/7] scanner: fix indesc_list stack to be in the correct order
Message-ID: <20200210101709.9182-7-fasnacht@protonmail.ch>
In-Reply-To: <20200210101709.9182-1-fasnacht@protonmail.ch>
References: <20200210101709.9182-1-fasnacht@protonmail.ch>
Feedback-ID: 67Kw-YMwrBchoIMLcnFuA64ZnJub6AgnNvfJUjsgbTTSp4dmymKgGy_PLLqmOsJ9F58iClONCeGYaqp9YPx84w==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This fixes the location displayed in error messages.

Signed-off-by: Laurent Fasnacht <fasnacht@protonmail.ch>
---
 src/scanner.l | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/scanner.l b/src/scanner.l
index 7f40c5c1..8407a2a1 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -668,7 +668,11 @@ addrstring=09({macaddr}|{ip4addr}|{ip6addr})
 static void scanner_push_indesc(struct parser_state *state,
 =09=09=09=09struct input_descriptor *indesc)
 {
-=09list_add_tail(&indesc->list, &state->indesc_list);
+=09if (!state->indesc) {
+=09=09list_add_tail(&indesc->list, &state->indesc_list);
+=09} else {
+=09=09list_add(&indesc->list, &state->indesc->list);
+=09}
 =09state->indesc =3D indesc;
 =09state->indesc_idx++;
 }
--=20
2.20.1


