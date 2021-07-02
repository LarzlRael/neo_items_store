export interface ITransaction {
    originUser: string;
    targetUser: string;
    amount: number;
    
    userOriginWallet: string,
    userTargetWallet: string
}