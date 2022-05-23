Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791DB530D3D
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 May 2022 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiEWKYE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 23 May 2022 06:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiEWKYC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 23 May 2022 06:24:02 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 May 2022 03:24:00 PDT
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D68749FBE
        for <netfilter-devel@vger.kernel.org>; Mon, 23 May 2022 03:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653300534; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=EPraphr3CUAp9l2vnDs6a/hVYKgUu6KSce91HmQj5vzxz/5Tsz8Oys3mats+mz5uMTScYwzZkA7IVAuQqtakJP9OVKOXrAg/4IUYft4cb5XBkY29siUhoAiV5kNzaG6ACtJ5wNd9G8AkM+arxQ0XVfeXtVkF96rJ62pqB/H+TWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653300534; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=zg33PhymcMaaORDEOh1+5z0y/b785oRWdZauIHkdNyU=; 
        b=bZDWg3uvG4fJp1muoUJn0vLa98dJaEc1fBM+m8nj8iwkCtsb5BLdveMg/hyVkQHQp+0vRX3pEdxUABCEyXQk4mS6pJQBysrsYxBy+3NknFPINwH3utUVUh1woJ69HHuI0efl1LWXd7S21QZI6KlEK2Jt9Z+oPl6d6rSfZJ+CI5g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=chandergovind.org;
        spf=pass  smtp.mailfrom=mail@chandergovind.org;
        dmarc=pass header.from=<mail@chandergovind.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653300534;
        s=zoho; d=chandergovind.org; i=mail@chandergovind.org;
        h=Message-ID:Date:Date:MIME-Version:To:To:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=zg33PhymcMaaORDEOh1+5z0y/b785oRWdZauIHkdNyU=;
        b=EyAofDqtvTnQek2TG3UUORrL20coJ/t3srb46a35nRpejCE7Tx56qxQwD++HXBgd
        xvoKHWOLjaCIp1A1FqoDwdmGPrmQpoTKUWWF3+GXTBApF+x61CuMPCYZm56/zAf1xmH
        891LGRDFdAMlYQXamWy07SLkPCTGHpSAJFygdGUA=
Received: from [192.168.1.38] (103.195.203.129 [103.195.203.129]) by mx.zohomail.com
        with SMTPS id 1653300532005258.262791295291; Mon, 23 May 2022 03:08:52 -0700 (PDT)
Message-ID: <1dcae0aa-466d-41bf-b050-9684e4b043cc@chandergovind.org>
Date:   Mon, 23 May 2022 15:37:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     netfilter-devel@vger.kernel.org
From:   Chander Govindarajan <mail@chandergovind.org>
Subject: [PATCH] nft: update json output ordering to place rules after chains
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Currently the json output of `nft -j list ruleset` interleaves rules
with chains

As reported in this bug,
https://bugzilla.netfilter.org/show_bug.cgi?id=1580
the json cannot be fed into `nft -j -f <file>` since rules may
reference chains that are created later

Instead create rules after all chains are output

Signed-off-by: ChanderG <mail@chandergovind.org>
---
  src/json.c | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/json.c b/src/json.c
index 0b7224c2..a525fd1b 100644
--- a/src/json.c
+++ b/src/json.c
@@ -1587,7 +1587,7 @@ json_t *optstrip_stmt_json(const struct stmt 
*stmt, struct output_ctx *octx)
  static json_t *table_print_json_full(struct netlink_ctx *ctx,
  				     struct table *table)
  {
-	json_t *root = json_array(), *tmp;
+	json_t *root = json_array(), *rules = json_array(), *tmp;
  	struct flowtable *flowtable;
  	struct chain *chain;
  	struct rule *rule;
@@ -1617,10 +1617,13 @@ static json_t *table_print_json_full(struct 
netlink_ctx *ctx,

  		list_for_each_entry(rule, &chain->rules, list) {
  			tmp = rule_print_json(&ctx->nft->output, rule);
-			json_array_append_new(root, tmp);
+			json_array_append_new(rules, tmp);
  		}
  	}

+	json_array_extend(root, rules);
+	json_decref(rules);
+
  	return root;
  }

-- 
2.27.0
