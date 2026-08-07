import { Box, Container, Typography } from '@mui/material';

export default function App() {
  return (
    <Container maxWidth="lg">
      <Box sx={{ py: 8 }}>
        <Typography variant="h3" component="h1" gutterBottom>
          LoanWise Method
        </Typography>
        <Typography>
          Student portal foundation. Authentication, tenant context, courses,
          progress, and certificates are implemented in subsequent work items.
        </Typography>
      </Box>
    </Container>
  );
}