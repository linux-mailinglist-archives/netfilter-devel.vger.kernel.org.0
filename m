Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997B92EBEB1
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Jan 2021 14:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbhAFNbZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Jan 2021 08:31:25 -0500
Received: from correo.us.es ([193.147.175.20]:56466 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAFNbY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:31:24 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7EFEAFC5E5
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 14:30:04 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7138BDA730
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 14:30:04 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 66D0DDA722; Wed,  6 Jan 2021 14:30:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 103FADA730
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 14:30:02 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 06 Jan 2021 14:30:02 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id E9E3D426CC84
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 14:30:01 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] cli: use plain readline() interface with libedit
Date:   Wed,  6 Jan 2021 14:30:34 +0100
Message-Id: <20210106133035.14816-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106133035.14816-1-pablo@netfilter.org>
References: <20210106133035.14816-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Instead of the alternate interface [1].

I spent a bit of time debugging an issue with libedit support
9420423900a2 ("cli: add libedit support") that broke tests/shell.

This is the reproducer:

 # nft -i << EOF
 list ruleset
 EOF

which makes rl_callback_read_char() loop forever on read() as shown by
strace. The rl_line_buffer variable does not accumulate the typed
characters as it should when redirecting the standard input for some
reason.

Given our interactive interface is fairly simple at this stage, switch
to use the readline() interface instead of rl_callback_read_char().

[1] https://docs.freebsd.org/info/readline/readline.info.Alternate_Interface.html

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/cli.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/src/cli.c b/src/cli.c
index 45811595fc77..4845e5cf1454 100644
--- a/src/cli.c
+++ b/src/cli.c
@@ -154,6 +154,16 @@ static void cli_complete(char *line)
 	free(line);
 }
 
+void cli_exit(void)
+{
+	rl_callback_handler_remove();
+	rl_deprep_terminal();
+	write_history(histfile);
+}
+#endif
+
+#if defined(HAVE_LIBREADLINE)
+
 static char **cli_completion(const char *text, int start, int end)
 {
 	return NULL;
@@ -179,11 +189,32 @@ int cli_init(struct nft_ctx *nft)
 	return 0;
 }
 
-void cli_exit(void)
+#elif defined(HAVE_LIBEDIT)
+
+int cli_init(struct nft_ctx *nft)
 {
-	rl_callback_handler_remove();
-	rl_deprep_terminal();
-	write_history(histfile);
+	char *line;
+
+	cli_nft = nft;
+	rl_readline_name = (char *)"nft";
+	rl_instream  = stdin;
+	rl_outstream = stdout;
+
+	init_histfile();
+
+	read_history(histfile);
+	history_set_pos(history_length);
+
+	rl_set_prompt(CMDLINE_PROMPT);
+	while ((line = readline(rl_prompt)) != NULL) {
+		line = cli_append_multiline(line);
+		if (!line)
+			continue;
+
+		cli_complete(line);
+	}
+
+	return 0;
 }
 
 #else /* HAVE_LINENOISE */
-- 
2.20.1

